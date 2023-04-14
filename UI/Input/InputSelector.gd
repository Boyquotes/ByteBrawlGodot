extends Container

var input_button = load("res://UI/Input/InputButton.tscn")
var input_button_group = load("res://UI/Input/InputButtonGroup.tres")

var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	var first_input: bool = true
	
	for i in ui_info.selected_stance.inputs.size():
		var box: InputButton = input_button.instantiate()

		if first_input:
			box.button_pressed = true
			first_input = false
		box.button_group = input_button_group
		box.input_index = i
		add_child(box)
