class_name Sequence

var actions: Array[Action]

func _init():
	pass

func _to_string():
	return \
"""
actions: %s
""" % str(actions)
