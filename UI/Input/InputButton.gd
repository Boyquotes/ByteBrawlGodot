extends Button
class_name InputButton

var input_index: int

var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	var events: Array[InputEvent] = InputMap.action_get_events(PlayerInput.PLAYER_INPUT[input_index])
	text = ""

	for i in range(len(events)):
		if i > 0:
			text += " / "
		text += events[i].as_text()

func _pressed():
	ui_info.selected_input_index = input_index
	ui_info.action_list.reset()
	ui_info.action_selector.reset()
