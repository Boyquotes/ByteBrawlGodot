class_name ActionButton
extends Button

var action_name: String

var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	text = action_name

func _pressed():
	var action = Action.new_from_name(action_name)
	
	ui_info.selected_sequence.actions.append(action)
	ui_info.action_list.reset()
	ui_info.action_selector.reset()
