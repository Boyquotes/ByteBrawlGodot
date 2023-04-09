extends Button
class_name InputButton

var input_index: int

func _ready():
	var events: Array[InputEvent] = InputMap.action_get_events(PlayerInput.PLAYER_INPUT[input_index])
	text = ""
	
	for i in range(len(events)):
		if i > 0:
			text += " / "
		text += events[i].as_text()

func _pressed():
	PlayerInfo.selected_input = input_index
	PlayerInfo.action_list.reset()
