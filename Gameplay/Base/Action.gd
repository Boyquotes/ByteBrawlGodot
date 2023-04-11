class_name Action
extends BaseNode


# UTILS
enum EType
{
	saveLocation,
	generateMateria,
	cast,
	throw,
	setTarget,
	changeStance
}

# PUBLIC
var type: EType = EType.saveLocation

var duration_min: float = 0.
var duration_max: float = INF

var duration: float = duration_min:
	set(x): duration = clamp(x, duration_min, duration_max)
var cancelable: bool = false
var blockable: bool = false
var end_sequence: bool = false
var requirements: Array[Requirement] = []
var block_action: bool = false
var block_movement: bool = false

# PRIVATE
var _started = false
var _current_duration: float = 0.
var _owner: Node

var _owner_gameplay: Gameplay:
	get: return _owner.get_node("gameplay") as Gameplay if _owner else null

var _owner_movement: Move:
	get: return _owner.get_node("movement") as Move if _owner else null

var _owner_materia_pool: MateriaPool:
	get: return _owner.get_node("materia_pool") as MateriaPool if _owner and _owner.has_node("materia_pool") else null

var _owner_target_locator: BaseNode2D:
	get: return _owner.get_node("target_locator") as BaseNode2D if _owner and _owner.has_node("target_locator") else null

# LIFECYCLE
func _enter_tree():
	if not _owner:
		_owner = find_parent("gameplay").get_parent()
	_current_duration = 0.
	_activate()

func _process(delta_time):
	_current_duration += delta_time
	if _current_duration >= duration:
		_done()


# LOGIC
func _activate():
	if not _owner: return 
	if not _can_be_cast():
		return _cancel()
	_block_action_if_needed(true)
	_block_movement_if_needed(true)
	activate()

func _done():
	if _owner:
		_block_action_if_needed(false)
		_block_movement_if_needed(false)
		done()
	remove_from_parent()

func _cancel():
	if _owner:
		cancel()

func _block_action_if_needed(value: bool):
	if not self.block_action: return
	var gameplay_node = _owner_gameplay
	if gameplay_node:
		gameplay_node.action_blocked = value

func _block_movement_if_needed(value: bool):
	if not self.block_movement: return
	var movement_node = _owner_movement
	if movement_node:
		movement_node.block_movement(value)

# INTERFACE
func activate():
	pass

func done():
	pass

func cancel():
	pass

func can_be_cast():
	return true

func _can_be_cast():
	if _owner_gameplay.action_blocked: return false
	return requirements.all(func(requirement): requirement.is_satisfied(_owner)) and can_be_cast()


# UI HELPER
func get_variables_to_set() -> Array[Field]:
	return []


# DEBUG
func _to_string() -> String:
	return """actiontype : %s | duration : %.2f""" % [type, duration]
