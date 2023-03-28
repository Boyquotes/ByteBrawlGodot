class_name Action

enum EActionType
{
	saveLocation,
	generateMateria,
	cast,
	throw,
	changeStateTarget
}

var type: EActionType
var duration: float
var cancelable: bool
var blockable: bool
var requirements: Array[Requirement]

func _init():
	pass

func canBeCast():
	for requirement in requirements:
		if not requirement.isSatisfied():
			return false
	return true
