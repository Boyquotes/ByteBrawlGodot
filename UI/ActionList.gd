class_name ActionList
extends Container

var ActionBox = load("res://UI/ActionUI.tscn")

func _ready():
	PlayerInfo.action_list = self
	create()

func create():
	var i = 0
	for action in PlayerInfo.get_selected_action_list():
		var box: ActionUI = ActionBox.instantiate()
		
		box.init(action["name"], action["parameters"], i)
		add_child(box)
		
		i += 1

func reset():
	print("reseting action list")
	for child in get_children():
		child.queue_free()
	
	create()
