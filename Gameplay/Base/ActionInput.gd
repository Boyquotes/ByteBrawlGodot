class_name ActionInput
extends BaseNode


# UTILS
enum ESequenceState
{
	Start,
	Pressed,
	Release,
	Cancel,
	Done,
}

const COOLDOWN_MIN = 0.
const COOLDOWN_MAX = 60.

# PUBLIC
var started_sequence: Sequence
var pressed_sequence: Sequence
var released_sequence: Sequence
var canceled_sequence: Sequence
var fields: Array[Field]

var cooldown: float = 1.

var cost: float:
	get: return [self.started_sequence, self.pressed_sequence, self.released_sequence] \
		.map(func(x): return x.cost) \
		.reduce(func(acc, x): return acc + x, 0)

# PRIVATE
var current_state: ESequenceState = ESequenceState.Done


# LIFECYCLE
func _init():
	self.started_sequence = Sequence.new(Sequence.EType.started_sequence)
	self.pressed_sequence = Sequence.new(Sequence.EType.pressed_sequence)
	self.released_sequence = Sequence.new(Sequence.EType.released_sequence)
	self.canceled_sequence = Sequence.new(Sequence.EType.canceled_sequence)
	self.init_fields()

func _ready():
	if self.started_sequence.actions.any(func(action: Action): return action.type == Action.EType.setTarget):
		self.released_sequence.create_action(ActionSwitchTargetMode.new())
		self.canceled_sequence.create_action(ActionSwitchTargetMode.new())

func _enter_tree():
	add_child(self.started_sequence)
	self.current_state = ESequenceState.Start

func _process(delta):
	if has_child(): return
	if self.current_state == ESequenceState.Start:
		self.current_state = ESequenceState.Pressed

	if self.current_state == ESequenceState.Pressed:
		add_child(pressed_sequence)
	elif self.current_state == ESequenceState.Release:
		add_child(released_sequence)
		self.current_state = ESequenceState.Done
	elif self.current_state == ESequenceState.Done:
		remove_from_parent()


# LOGIC
func stop():
	if self.current_state == ESequenceState.Done:
		return
	if self.current_state == ESequenceState.Pressed:
		end_sequence()
	self.current_state = ESequenceState.Release

func end_sequence():
	if has_child():
		remove_child(get_child(0))


# MEMORY
func delete():
	self.started_sequence.delete()
	self.pressed_sequence.delete()
	self.released_sequence.delete()
	self.canceled_sequence.delete()
	self.queue_free()


# UI HELPER
func init_fields():
	self.fields = [
		Field.Float("cooldown", "Cooldown", func(): return cooldown, func(x): cooldown = x, COOLDOWN_MIN, COOLDOWN_MAX, CostCurve.new(10., .1, CostCurve.EMode.Linear))
	]

func to_json():
	return {
		"cooldown": cooldown,
		"sequence": {
			"started_sequence": started_sequence.to_json(),
			"pressed_sequence": pressed_sequence.to_json(),
			"released_sequence": released_sequence.to_json(),
			"canceled_sequence": canceled_sequence.to_json(),
		}
	}

func from_json(data: Dictionary):
	self.cooldown = data.cooldown
	for sequence_name in data.sequence.keys():
		self[sequence_name].from_json(data.sequence[sequence_name])

# DEBUG
func _to_string():
	return "".join([started_sequence, pressed_sequence, released_sequence, canceled_sequence])
