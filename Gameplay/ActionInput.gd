class_name ActionInput
extends Node

var started_sequence: Sequence
var pressed_sequence: Sequence
var released_sequence: Sequence
var canceled_sequence: Sequence

enum ESequenceState { INIT, START, PRESSED, RELEASE, CANCEL, DONE }

var current_state: ESequenceState

func _init():
	self.started_sequence = Sequence.new()
	self.pressed_sequence = Sequence.new()
	self.released_sequence = Sequence.new()
	self.canceled_sequence = Sequence.new()
	pass

func _ready():
	print("ACTION READY")

func _enter_tree():
	add_child(self.started_sequence)
	self.current_state = ESequenceState.START
	print("STARTED_SEQUENCE")

func _process(delta):
	print(get_child_count())
	if self.current_state == ESequenceState.START:
		if get_child_count() != 0: return
		self.current_state = ESequenceState.PRESSED
	if self.current_state == ESequenceState.PRESSED:
		if get_child_count() != 0: return
		add_child(pressed_sequence)
		print("PRESSED_SEQUENCE")
	elif self.current_state == ESequenceState.RELEASE:
		if get_child_count() != 0: return
		add_child(released_sequence)
		self.current_state = ESequenceState.DONE
		print("RELEASE_SEQUENCE")
	elif self.current_state == ESequenceState.DONE:
		if get_child_count() != 0: return
		remove_from_parent()

func _exit_tree():
	self.current_state = ESequenceState.INIT
	print("ACTION EXIT TREE")

func stop():
	if self.current_state != ESequenceState.START:
		end_sequence()
	self.current_state = ESequenceState.RELEASE

func remove_from_parent():
	get_parent().remove_child(self)

func end_sequence():
	if get_child_count() >= 0:
		remove_child(get_child(0))

func _to_string():
	return \
"""
initSequence : %s
pressedSequence : %s
releaseSequence : %s
cancelSequence : %s
""" % [started_sequence, pressed_sequence, released_sequence, canceled_sequence]
