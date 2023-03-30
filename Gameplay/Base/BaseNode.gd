class_name BaseNode
extends Node

func remove_from_parent():
	get_parent().remove_child(self)

func has_child():
	return get_child_count() != 0
