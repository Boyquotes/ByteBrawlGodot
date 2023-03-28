class_name Stance

var inputs: Array[ActionInput] = []

func _init():
	for i in range(4):
		inputs.append(ActionInput.new())

