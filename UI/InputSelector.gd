extends Container

var input_button = load("res://UI/InputButton.tscn")
var input_button_group = load("res://UI/InputButtonGroup.tres")

func _init():
	var player_inputs: Dictionary = PlayerInfo.stances["normal"]["inputs"]
	var first_input: bool = true
	
	for input_name in player_inputs:
		var box: InputButton = input_button.instantiate()
		
		if first_input:
			box.button_pressed = true
			first_input = false
		box.button_group = input_button_group
		box.text = input_name
		box.input_name = input_name
		add_child(box)
