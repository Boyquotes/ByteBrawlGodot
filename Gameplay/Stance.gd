class_name Stance
extends Node

var is_active: bool = false

var inputs: Array[ActionInput] = []

func _input(event):
	var input = PlayerInput.get_input_type(event)
	if not input: return
	if input.type == PlayerInput.EInputType.PRESS: active_input(input.key)
	if input.type == PlayerInput.EInputType.RELEASE: deactive_input(input.key)

func _init():
	for input in PlayerInput.PLAYER_INPUT.size():
		inputs.append(ActionInput.new())

func _ready():
	print("READY")

func _enter_tree():
	print("ENTER TREE")
	
func _exit_tree():
	print("EXIT TREE")

func _process(delta):
	pass

func _to_string() -> String:
	return \
"""inputs : %s""" % str(inputs)

func active_input(index: int):
	print("ACTIVE_INPUT")
	if index == -1: return
	add_child(inputs[index])

func deactive_input(index: int):
	print("DEACTIVE_INPUT")
	if index == -1: return
	inputs[index].stop()
