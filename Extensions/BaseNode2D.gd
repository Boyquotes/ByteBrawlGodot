class_name BaseNode2D
extends Node2D

func remove_from_parent():
	if get_parent():
		get_parent().remove_child(self)

func has_child():
	return get_child_count() != 0
