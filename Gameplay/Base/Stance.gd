class_name Stance
extends BaseNode


# PUBLIC
var inputs: Array[ActionInput] = []
var stance_name: String

# LIFECYCLE
func _init(stance_name: String):
	self.stance_name = stance_name
	self.name = "stance"
	for input in PlayerInput.PLAYER_INPUT.size():
		inputs.append(ActionInput.new())

func _enter_tree():
	pass
	
func _exit_tree():
	pass

func _process(delta):
	pass

# DEBUG
func _to_string() -> String:
	return \
"""inputs : %s""" % str(inputs)
