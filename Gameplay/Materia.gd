class_name Materia

enum EMateriaType
{
	Fire,
	Water,
	Wind,
	Earth
}

var generationTime: float
var type: EMateriaType

func _init():
	pass

func _to_string():
	return \
"""type : %s
generationTime : %.3f
""" % [type, generationTime]
