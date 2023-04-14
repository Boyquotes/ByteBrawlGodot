class_name ActionUI
extends Container

var action_name: String

var drag_point = null
var ghost_action: ActionUI
var should_set_ghost_pos: bool = false
var ghost_pos

var parameters_container: Container

func init(action_name: String, index: int):
	self.action_name = action_name
	(get_node("Header/Panel/Name") as Label).text = action_name
	
	parameters_container = get_node("ScrollContainerListParameters/ListParameters")
	var action: Action = ActionsInfo.actions.filter(func (x): return x.display_name == action_name)[0].new_from_json(PlayerInfo.get_selected_actions_values()[index]["values"])
	
	for field in action.fields:
		field.connect("on_value_changed", input_value_changed)
		parameters_container.add_child(field)

func _process(delta):
	if should_set_ghost_pos:
		should_set_ghost_pos = false
		ghost_action.global_position = ghost_pos

func get_action_greatest_cost():
	for parameter in parameters_container.get_children():
		
		if parameter is FieldSlider:
			parameter.cost_curve

func get_action_values():
	return PlayerInfo.get_selected_actions_values()[get_index()]["values"]

func input_value_changed(field: Field):
	get_action_values()[field.field_name] = field.getter.call()

func _on_cancel_pressed():
	PlayerInfo.get_selected_actions_values().remove_at(get_index())
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
