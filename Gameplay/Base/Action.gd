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
	changeStance,
	cancelInput,
}

# PUBLIC
var type: EType = EType.saveLocation

var duration_min: float = 0.
var duration_max: float = INF

var duration: float = duration_min:
	set(x): duration = clamp(x, duration_min, duration_max)
var cancelable: bool = false
var end_sequence: bool = false

var block_action: bool = false
var block_movement: bool = false

var param_cost: Dictionary = {}

var fields: Array[Field] = []

static func get_allowed_sequences() -> Array[Sequence.EType]: return []
var allowed_sequences: Array[Sequence.EType]:
	get: return get_allowed_sequences()

static func get_action_name(): return "! NO ACTION NAME !"
var action_name: String:
	get: return get_action_name()

var cost: float:
	get: return self.fields.map(func(x): return x.cost).reduce(func(acc, x): return acc * x, 1)

signal changed

# PRIVATE
var _started = false
var _current_duration: float = 0.
var _owner: Player

# LIFECYCLE
func _init():
	init_fields()
	for field in fields:
		field.changed.connect(func(_new, _old): changed.emit())

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
		self.call_deferred("_cancel")
		return
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
		_block_action_if_needed(false)
		_block_movement_if_needed(false)
		cancel()
	remove_from_parent()

func _block_action_if_needed(value: bool):
	if not self.block_action: return
	var gameplay_node = _owner.gameplay
	if gameplay_node:
		gameplay_node.action_blocked = value

func _block_movement_if_needed(value: bool):
	if not self.block_movement: return
	var movement_node = _owner.movement
	if movement_node:
		movement_node.block_movement(value)

func remove_all_descendants():
	self._cancel()

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
	if _owner.gameplay.action_blocked: return false
	return can_be_cast()

# MEMORY
func delete():
	for field in fields:
		field.queue_free()
	self.queue_free()


func init_fields():
	pass

func to_json():
	var values: Dictionary
	for field in fields:
		values[field.field_name] = field.getter.call()
	return {
		"name": self.action_name,
		"values": values
	}

func from_json(data: Dictionary):
	for field in fields:
		field.setter.call(data.values[field.field_name])

static func new_from_name(name: String) -> Action:
	var ActionClasses = ActionsInfo.actions.filter(func (X): return X.get_action_name() == name)
	return ActionClasses[0].new() if ActionClasses else null

static func new_from_json(data: Dictionary) -> Action:
	var action = new_from_name(data.name)
	if not action: return null
	action.from_json(data)
	return action

# DEBUG
func _to_string() -> String:
	return """actiontype : %s | duration : %.2f""" % [type, duration]
