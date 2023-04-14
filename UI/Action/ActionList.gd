class_name ActionList
extends Container

var ActionBox = load("res://UI/Action/ActionUI.tscn")

var ui_info: UIInfo

func _ready():
	ui_info = find_parent("InputActionCreationMenu")
	ui_info.action_list = self
	create()

func create():
	var i = 0
	for action in ui_info.selected_sequence.actions:
		var box: ActionUI = ActionBox.instantiate()

		box.init(action["name"], i, ui_info)
		add_child(box)
		
		i += 1

func reset():
	for child in get_children():
		child.free()
	
	create()
