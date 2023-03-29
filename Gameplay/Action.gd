class_name Action
extends Node

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

var _current_duration: float = 0.

func _init():
	print(to_string())

func _enter_tree():
	_current_duration = 0.
	_activate(find_parent("current_stance").get_parent())
	

func _process(delta_time):
	_current_duration += delta_time
	if _current_duration >= duration:
		_done(find_parent("current_stance").get_parent())

func can_be_cast(entity: Node):
	for requirement in requirements:
		if not requirement.is_satisfied(entity):
			return false
	return true

func activate(entity: Node):
	print(entity)

func _activate(entity: Node):
	activate(entity)

func done(entity: Node):
	pass

func _done(entity: Node):
	done(entity)
	remove_from_parent()

func cancel(entity: Node):
	pass

func get_variables_to_set() -> Array[String]:
	return []

func remove_from_parent():
	get_parent().remove_child(self)

func _to_string() -> String:
	return """type : %s
duration : %.3f
cancelable : %s
blockable : %s
requirements : %s""" % [type, duration, cancelable, blockable, requirements]
