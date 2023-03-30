extends Container

var action_button = load("res://UI/ActionButton.tscn")
var actions: Array = load("res://Data/Actions.json").data

func _init():
	for action in actions:
		var box: ActionButton = action_button.instantiate()
		
		box.text = action["name"]
		box.action = action
		add_child(box)
