class_name Stance

var is_active: bool = false

var map_inputs: Dictionary = {
	"input_1": 0,
	"input_2": 1,
	"input_3": 2,
	"input_4": 3,
}

var inputs: Array[ActionInput] = []

func _init():
	for key in map_inputs: inputs.append(ActionInput.new())

func _to_string() -> String:
	return \
"""inputs : %s""" % str(inputs)
