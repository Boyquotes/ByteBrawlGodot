class_name SequenceButton
extends Button

var sequence_name: String

var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	sequence_name = editor_description

func _pressed():
	ui_info.selected_sequence_name = sequence_name
	ui_info.action_list.reset()
	ui_info.action_selector.reset()
