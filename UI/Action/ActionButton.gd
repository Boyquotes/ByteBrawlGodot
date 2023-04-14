class_name ActionButton
extends Button

var action_name: String

var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	text = action_name

func _pressed():
	var action_values = {"name": action_name, "values": ActionsInfo.actions.filter(func (x): return x.display_name == action_name)[0].get_default_values()}
	var action = Action.new_from_json(action_values)
	
	ui_info.selected_sequence.actions.append(action)
	ui_info.action_list.reset()
	ui_info.action_selector.reset()
