class_name Sequence

var actions: Array[Action]

func _init():
	pass

func _to_string():
	var str = ""
	for action in actions:
		str += action.to_string()
	return str
