class_name Action

enum EActionType
{
	saveLocation,
	generateMateria,
	cast,
	throw,
	changeStateTarget
}

var type: EActionType = EActionType.saveLocation
var duration: float = 0.
var cancelable: bool = false
var blockable: bool = false
var requirements: Array[Requirement] = []

func _init():
	print(to_string())

func canBeCast(player: Node):
	for requirement in requirements:
		if not requirement.isSatisfied(player):
			return false
	return true

func activate(player: Node):
	pass

func cancel(player: Node):
	pass

func get_variables_to_set() -> Array[String]:
	return []

func _to_string() -> String:
	return """type : %s
duration : %.3f
cancelable : %s
blockable : %s
requirements : %s""" % [type, duration, cancelable, blockable, requirements]
