extends Node
class_name InputDetailsManager

var input_details_to_instantiate = load("res://UI/Input/InputDetails.tscn")
var input_details: InputDetails = null

func _ready():
	find_parent("InputActionCreationMenu").input_details_manager = self
	create()

func create():
	input_details = input_details_to_instantiate.instantiate()
	add_child(input_details)
	move_child(input_details, 0)

func reset():
	if input_details != null:
		input_details.queue_free()
	
	create()
