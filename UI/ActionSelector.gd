class_name ActionSelector
extends Container

var action_button = load("res://UI/ActionButton.tscn")


func _ready():
	PlayerInfo.action_selector = self
	create()

func create():
	var sequence = PlayerInfo.get_selected_sequence_type()
	var actions = ActionsInfo.actions.filter(func (x): return x.allowed_sequence.has(sequence));
	for action in actions:
		var box: ActionButton = action_button.instantiate()

		box.action_name = action.display_name
		add_child(box)


func reset():
	for child in get_children():
		child.free()

	create()
