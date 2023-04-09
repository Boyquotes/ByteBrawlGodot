class_name ActionButton
extends Button

var action_name: String

func _ready():
	text = action_name

func _pressed():
	var action_values = {"name": action_name, "values": ActionsInfo.actions[action_name].get_default_values()}
	PlayerInfo.get_selected_actions_values().append(action_values)
	PlayerInfo.action_list.reset()
