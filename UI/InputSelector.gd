extends Container

var input_button = load("res://UI/InputButton.tscn")
var input_button_group = load("res://UI/InputButtonGroup.tres")

func _init():
	var first_input: bool = true
	
	for i in PlayerInfo.player_data[PlayerInfo.selected_stance]["inputs"][PlayerInfo.selected_input].size():
		var box: InputButton = input_button.instantiate()

		if first_input:
			box.button_pressed = true
			first_input = false
		box.button_group = input_button_group
		box.input_index = i
		add_child(box)
