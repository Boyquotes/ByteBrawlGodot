class_name ActionSelector
extends Container

var action_button = load("res://UI/Action/ActionButton.tscn")

var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	ui_info.action_selector = self
	create()

func create():
	var sequence = ui_info.selected_sequence
	var actions = ActionsInfo.actions.filter(func (x): return x.allowed_sequence.has(sequence.type));
	for action in actions:
		var box: ActionButton = action_button.instantiate()

		box.action_name = action.display_name
		add_child(box)


func reset():
	for child in get_children():
		child.queue_free()

	create()
