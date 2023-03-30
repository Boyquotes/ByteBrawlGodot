class_name Action
extends BaseNode


# UTILS
enum EType
{
	saveLocation,
	generateMateria,
	cast,
	throw,
	changeStateTarget,
	changeStance
}


# PUBLIC
var type: EType = EType.saveLocation
var duration: float = 0.
var cancelable: bool = false
var blockable: bool = false
var end_sequence: bool = false
var requirements: Array[Requirement] = []
var allowed_stance: Array[Sequence.EType] = []
var block_action: bool = false
var block_movement: bool = false

# PRIVATE
var _current_duration: float = 0.
var _owner: Node

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
	if _owner and can_be_cast():
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
	var gameplay_node = _owner.get_node("gameplay/stance")
	if gameplay_node:
		gameplay_node

func _block_movement_if_needed(value: bool):
	if not self.block_movement: return
	var movement_node = _owner.get_node("movement")
	if movement_node:
		(movement_node as Move).block_movement(value)

# INTERFACE
func activate():
	pass

func done():
	pass

func cancel():
	pass


func can_be_cast():
	for requirement in requirements:
		if not requirement.is_satisfied(_owner):
			return false
	return true


# UI HELPER
func get_variables_to_set() -> Array[ActionParameterField]:
	return []


# DEBUG
func _to_string() -> String:
	return """actiontype : %s | duration : %.2f""" % [type, duration]
