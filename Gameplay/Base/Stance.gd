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

# UI HELPER
func to_json():
	return {
		"name": self.stance_name,
		"inputs": self.inputs.map(func(x): return x.to_json())
	}

func from_json(data: Dictionary):
	self.stance_name = data.name
	for i in data.inputs.size():
		self.inputs[i].from_json(data.inputs[i])

# DEBUG
func _to_string() -> String:
	return \
"""inputs : %s""" % str(inputs)
