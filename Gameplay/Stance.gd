class_name Stance
extends Node

var is_active: bool = false

var inputs: Dictionary = {}

func _input(event):
	var input = PlayerInput.get_input_type(event)
	if not input: return
	if input.type == PlayerInput.EInputType.PRESS: active_input(input.key)
	if input.type == PlayerInput.EInputType.RELEASE: deactive_input(input.key)

func _init():
	for input_name in PlayerInput.PLAYER_INPUT:
		inputs[input_name] = ActionInput.new()

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

func active_input(input_name: String):
	print("active %s" % (inputs[input_name].get_parent() == self))
	if input_name not in inputs or inputs[input_name].get_parent() == self: return
	print("activate")
	add_child(inputs[input_name])

func deactive_input(input_name: String):
	print("deactive %s" % (inputs[input_name].get_parent() != self))
	if input_name not in inputs or inputs[input_name].get_parent() != self: return
	print("deactivate")
	inputs[input_name].stop()
