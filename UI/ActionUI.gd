class_name ActionUI
extends Container

var action_parameter = load("res://UI/Parameter.tscn")

var action_name: String

func init(action_name: String, index: int):
	self.action_name = action_name
	(get_node("Header/Name") as LineEdit).text = action_name
	
	var parameters_container: Container = get_node("ScrollContainerListParameters/ListParameters")
	var action: Action = ActionsInfo.actions[action_name].new_from_editor(PlayerInfo.get_selected_actions_values()[index]["values"])
	for param in action.get_variables_to_set():
		param.connect("on_value_changed", input_value_changed)
		parameters_container.add_child(param)

func get_action_values():
	return PlayerInfo.get_selected_actions_values()[get_index()]["values"]

func input_value_changed(field: Field):
	get_action_values()[field.field_name] = field.getter.call()

func _on_cancel_pressed():
	PlayerInfo.get_selected_actions_values().remove_at(get_index())
	queue_free()
