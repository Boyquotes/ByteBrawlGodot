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
	pass
	
func _exit_tree():
	pass

func _process(delta):
	pass

func _to_string() -> String:
	return \
"""inputs : %s""" % str(inputs)

func active_input(index: int):
	print("active %s" % (inputs[index].get_parent() == self))
	if index == -1 or inputs[index].get_parent() == self: return
	print("activate")
	add_child(inputs[index])

func deactive_input(index: int):
	print("deactive %s" % (inputs[index].get_parent() != self))
	if index == -1 or inputs[index].get_parent() != self: return
	print("deactivate")
	inputs[index].stop()
