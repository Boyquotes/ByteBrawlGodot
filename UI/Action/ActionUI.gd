class_name ActionUI
extends Container

var action: Action

var drag_point = null
var ghost_action: ActionUI
var should_set_ghost_pos: bool = false
var ghost_pos

var parameters_container: Container

var ui_info: UIInfo

func init(index: int, ui_info: UIInfo):
	self.action = ui_info.selected_sequence.actions[index]
	self.ui_info = ui_info
	
	(get_node("Header/Panel/Name") as Label).text = action.action_name
	
	parameters_container = get_node("ScrollContainerListParameters/ListParameters")
	
	for field in action.fields:
		var new_ui_field: UIField = field.instantiate_ui_field()
		parameters_container.add_child(new_ui_field)

func _process(delta):
	if should_set_ghost_pos:
		should_set_ghost_pos = false
		ghost_action.global_position = ghost_pos

func _on_cancel_pressed():
	ui_info.selected_sequence.actions[get_index()].queue_free()
	ui_info.selected_sequence.actions.remove_at(get_index())
	queue_free()

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			drag_point = get_global_mouse_position() - get_position()
			instantiate_ghost_action()
			set_position(get_global_mouse_position() - drag_point)
		else:
			global_position = ghost_action.global_position
			drag_point = null
			ghost_action.free()
			ghost_action = null

	if event is InputEventMouseMotion and drag_point != null:
		set_position(get_global_mouse_position() - drag_point)
		
		var nearest_child: Node = find_nearest_child(global_position.distance_to(ghost_pos))
		if nearest_child == null:
			ghost_action.global_position = ghost_pos
			return

		var nearest_pos = nearest_child.global_position
		
		get_parent().move_child(self, nearest_child.get_index())
		ghost_action.global_position = nearest_pos
		ghost_pos = nearest_pos

func disable_scripts_recursive(node: Node):
	if node.script != null:
		node.script = null
	for child in node.get_children():
		disable_scripts_recursive(child)

func find_nearest_child(min_distance: float):
	var nearest_child: Node = null
	for child in get_parent().get_children():
		if child != self:
			var distance = global_position.distance_to(child.global_position)
			if distance < min_distance:
				min_distance = distance
				nearest_child = child
	return nearest_child

func instantiate_ghost_action():
	ghost_action = duplicate()
	
	ghost_action.size = size
	ghost_action.modulate = Color(1, 1, 1, 0.3)
	disable_scripts_recursive(ghost_action)
	
	should_set_ghost_pos = true
	ghost_pos = global_position
	ghost_action.global_position = global_position
	
	find_parent("InputActionCreationMenu").find_child("GhostActionContainer").add_child(ghost_action)
