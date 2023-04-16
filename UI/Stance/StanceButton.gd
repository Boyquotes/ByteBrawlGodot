extends Button
class_name StanceButton

var stance_name: String
var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	text = stance_name

func _pressed():
	ui_info.selected_stance_name = stance_name
	ui_info.action_list.reset()
	ui_info.action_selector.reset()
	ui_info.input_details_manager.reset()
