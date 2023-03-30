class_name Action
extends BaseNode


# UTILS
enum EActionType
{
	saveLocation,
	generateMateria,
	cast,
	throw,
	changeStateTarget
}


# PUBLIC
var type: EActionType = EActionType.saveLocation
var duration: float = 0.
var cancelable: bool = false
var blockable: bool = false
var requirements: Array[Requirement] = []


# PRIVATE
var _current_duration: float = 0.


# LIFECYCLE
func _enter_tree():
	_current_duration = 0.
	_activate(find_parent("stance").get_parent())
	

func _process(delta_time):
	_current_duration += delta_time
	if _current_duration >= duration:
		_done(find_parent("stance").get_parent())


# LOGIC
func _activate(entity: Node):
	activate(entity)

func _done(entity: Node):
	done(entity)
	remove_from_parent()

func _cancel(entity: Node):
	cancel(entity)


# INTERFACE
func activate(entity: Node):
	pass

func done(entity: Node):
	pass

func cancel(entity: Node):
	pass


func can_be_cast(entity: Node):
	for requirement in requirements:
		if not requirement.is_satisfied(entity):
			return false
	return true


# UI HELPER
func get_variables_to_set() -> Array[String]:
	return []


# DEBUG
func _to_string() -> String:
	return """type : %s
duration : %.3f
cancelable : %s
blockable : %s
requirements : %s""" % [type, duration, cancelable, blockable, requirements]
