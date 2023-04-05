extends Button
class_name InputButton

var input_name: String

func _pressed():
	PlayerInfo.selected_input = input_name
