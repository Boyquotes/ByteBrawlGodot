class_name Stance
extends Node


# PUBLIC
var inputs: Array[ActionInput] = []


# LIFECYCLE
func _init():
	self.name = "stance"
	for input in PlayerInput.PLAYER_INPUT.size():
		inputs.append(ActionInput.new())


# LOGIC
func _input(event):
	var input = PlayerInput.get_input_type(event)
	if not input: return
	if input.type == PlayerInput.EInputType.Press: return active_input(input.key)
	if input.type == PlayerInput.EInputType.Release: return deactive_input(input.key)

func active_input(index: int):
	if index == -1 or inputs[index].get_parent() == self: return
	add_child(inputs[index])

func deactive_input(index: int):
	if index == -1 or inputs[index].get_parent() != self: return
	inputs[index].stop()


# DEBUG
func _to_string() -> String:
	return \
"""inputs : %s""" % str(inputs)
