class_name ActionButton
extends Button

var action_name: String

func _ready():
	text = action_name

func _pressed():
	var action_values = {"name": action_name, "values": {}}
	for param_name in ActionInfo.actions_info[action_name]:
		action_values["values"][param_name] = ActionInfo.actions_info[action_name][param_name]["default_value"]
	PlayerInfo.get_selected_actions_values().append(action_values)
	PlayerInfo.action_list.reset()
