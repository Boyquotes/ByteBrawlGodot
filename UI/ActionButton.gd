class_name ActionButton
extends Button

var action: Dictionary

func _pressed():
	PlayerInfo.get_selected_action_list().append(action.duplicate(true))
	PlayerInfo.action_list.reset()
