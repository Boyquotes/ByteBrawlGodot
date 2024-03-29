class_name ActionInput
extends BaseNode


# UTILS
enum ESequenceState
{
	Start,
	Pressed,
	Release,
	Cancel,
	Cooldown,
	Done,
}

const COOLDOWN_MIN = 0.
const COOLDOWN_MAX = 60.
var COOLDOWN_COST_CURVE = CostCurve.new(10., .1, CostCurve.EMode.Linear)
var cooldown_timer: Timer = Timer.new()

var COOLDOWN_FIELD = Field.Float("cooldown", "Cooldown", func(): return self.cooldown_timer.wait_time, func(x): self.cooldown_timer.wait_time = x, COOLDOWN_MIN, COOLDOWN_MAX, COOLDOWN_COST_CURVE)

# PUBLIC
var started_sequence: Sequence
var pressed_sequence: Sequence
var released_sequence: Sequence
var canceled_sequence: Sequence
var fields: Array[Field]

var sequence_container = BaseNode.new()

var icon_index: int = 0
var icon: Texture2D:
	get: return Icons.get_texture("inputs", icon_index)
var icon_cooldown_index: int = 0
var icon_cooldown: Texture2D:
	get: return Icons.get_texture("inputs", icon_cooldown_index)

var sequences: Array[Sequence]:
	get: return [self.started_sequence, self.pressed_sequence, self.released_sequence]

var cost: float:
	get: return sequences.map(func(x): return x.cost).reduce(func(acc, x): return acc + x, 0) * COOLDOWN_FIELD.cost

signal changed

# PRIVATE
var current_state: ESequenceState = ESequenceState.Done


# LIFECYCLE
func _init():
	self.started_sequence = Sequence.new(Sequence.EType.started_sequence)
	self.pressed_sequence = Sequence.new(Sequence.EType.pressed_sequence)
	self.released_sequence = Sequence.new(Sequence.EType.released_sequence)
	self.canceled_sequence = Sequence.new(Sequence.EType.canceled_sequence)
	for sequence in sequences:
		sequence.changed.connect(func(): changed.emit())
	self.init_fields()
	for field in fields:
		field.changed.connect(func(_old, _new): changed.emit())

	add_child(sequence_container)
	add_child(cooldown_timer)
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(cooldown_ended)

func _ready():
	if self.started_sequence.actions.any(func(action: Action): return action.type == Action.EType.setTarget):
		self.released_sequence.create_action(ActionRemoveTarget.new())
		self.canceled_sequence.create_action(ActionRemoveTarget.new())


func _enter_tree():
	if self.current_state != ESequenceState.Cooldown:
		sequence_container.add_child(self.started_sequence)
		self.current_state = ESequenceState.Start

func _process(delta_time):
	if sequence_container.has_child(): return
	if self.current_state == ESequenceState.Start:
		self.current_state = ESequenceState.Pressed

	if self.current_state == ESequenceState.Pressed:
		sequence_container.add_child(pressed_sequence)
	elif self.current_state == ESequenceState.Release:
		sequence_container.add_child(released_sequence)
		self.current_state = ESequenceState.Cooldown
	elif self.current_state == ESequenceState.Cancel:
		sequence_container.add_child(canceled_sequence)
		self.current_state = ESequenceState.Cooldown
	elif self.current_state == ESequenceState.Cooldown and cooldown_timer.is_stopped():
		cooldown_timer.start()
	elif self.current_state == ESequenceState.Done:
		remove_from_parent()

func cooldown_ended():
	self.current_state = ESequenceState.Done

# LOGIC
func stop():
	if self.current_state == ESequenceState.Done or self.current_state == ESequenceState.Cooldown:
		return
	if self.current_state == ESequenceState.Pressed:
		end_sequence()
	self.current_state = ESequenceState.Release

func cancel():
	if self.current_state == ESequenceState.Done or self.current_state == ESequenceState.Cooldown:
		return
	if self.current_state == ESequenceState.Pressed:
		end_sequence()
	self.current_state = ESequenceState.Cancel

func end_sequence():
	sequence_container.remove_all_descendants()

# MEMORY
func delete():
	self.started_sequence.delete()
	self.pressed_sequence.delete()
	self.released_sequence.delete()
	self.canceled_sequence.delete()
	self.queue_free()

func remove_all_descendants():
	sequence_container.remove_all_descendants()
	self.current_state = ESequenceState.Cooldown

# UI HELPER
func init_fields():
	self.fields = [COOLDOWN_FIELD]

func to_json():
	return {
		"icon_index": icon_index,
		"icon_cooldown_index": icon_cooldown_index,
		"cooldown": cooldown_timer.wait_time,
		"sequence": {
			"started_sequence": started_sequence.to_json(),
			"pressed_sequence": pressed_sequence.to_json(),
			"released_sequence": released_sequence.to_json(),
			"canceled_sequence": canceled_sequence.to_json(),
		}
	}

func from_json(data: Dictionary):
	self.icon_index = data.icon_index
	self.cooldown_timer.wait_time = data.cooldown
	for sequence_name in data.sequence.keys():
		self[sequence_name].from_json(data.sequence[sequence_name])

# DEBUG
func _to_string():
	return "".join([started_sequence, pressed_sequence, released_sequence, canceled_sequence])
