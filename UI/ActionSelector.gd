extends Container

var action_button = load("res://UI/ActionButton.tscn")

func _init():
	for action_name in ActionsInfo.actions:
		var box: ActionButton = action_button.instantiate()
		
		box.action_name = action_name
		add_child(box)
