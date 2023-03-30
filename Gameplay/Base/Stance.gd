class_name Stance
extends BaseNode


# PUBLIC
var inputs: Array[ActionInput] = []


# LIFECYCLE
func _init():
	self.name = "stance"
	for input in PlayerInput.PLAYER_INPUT.size():
		inputs.append(ActionInput.new())


func _enter_tree():
	pass
	
func _exit_tree():
	pass

func _process(delta):
	pass

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
