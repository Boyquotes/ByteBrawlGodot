class_name ActionInput
extends Node

var initSequence: Sequence
var pressedSequence: Sequence
var releaseSequence: Sequence
var cancelSequence: Sequence

func _init():
	pass

func _ready():
	print("ACTION READY")

func _process(delta):
	# MAINTAIN SEQUENCE IF INIT IS DONE
	pass

func _enter_tree():
	# INIT SEQUENCE
	print("ACTION ENTER TREE")
	
func _exit_tree():
	print("ACTION EXIT TREE")

func stop():
	# END SEQUENCE
	get_parent().remove_child(self)
	pass

func _to_string():
	return \
"""
initSequence : %s
pressedSequence : %s
releaseSequence : %s
cancelSequence : %s
""" % [initSequence, pressedSequence, releaseSequence, cancelSequence]
