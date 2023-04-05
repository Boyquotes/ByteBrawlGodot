extends Container

var action_button = load("res://UI/ActionButton.tscn")
var actions: Dictionary = load("res://Data/Actions.json").data

func _init():
	for action_name in actions:
		var box: ActionButton = action_button.instantiate()
		
		box.action_name = action_name
		add_child(box)
