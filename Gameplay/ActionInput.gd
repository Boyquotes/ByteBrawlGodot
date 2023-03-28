class_name ActionInput

var initSequence: Sequence
var pressedSequence: Sequence
var releaseSequence: Sequence
var cancelSequence: Sequence

func _init():
	pass

func _to_string():
	return \
"""
initSequence : %s
pressedSequence : %s
releaseSequence : %s
cancelSequence : %s
""" % [initSequence, pressedSequence, releaseSequence, cancelSequence]
