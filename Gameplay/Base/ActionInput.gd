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


# PUBLIC
var started_sequence: Sequence
var pressed_sequence: Sequence
var released_sequence: Sequence
var canceled_sequence: Sequence


# PRIVATE
var current_state: ESequenceState = ESequenceState.Done


# LIFECYCLE
func _init():
	self.started_sequence = Sequence.new(Sequence.EType.Start)
	self.pressed_sequence = Sequence.new(Sequence.EType.Press)
	self.released_sequence = Sequence.new(Sequence.EType.Release)
	self.canceled_sequence = Sequence.new(Sequence.EType.Cancel)

func _ready():
	if self.started_sequence.actions.any(func(action: Action): return action.type == Action.EType.setTarget):
		self.released_sequence.actions.append(ActionSwitchTargetMode.new(ActionSwitchTargetMode.ETargetType.None))
		self.canceled_sequence.actions.append(ActionSwitchTargetMode.new(ActionSwitchTargetMode.ETargetType.None))

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


# DEBUG
func _to_string():
	return "".join([started_sequence, pressed_sequence, released_sequence, canceled_sequence])
