class_name BaseNode
extends Node

func remove_from_parent():
	if get_parent():
		get_parent().remove_child(self)

func has_child():
	return get_child_count() != 0

func remove_all_descendants():
	for child in self.get_children():
		if child.has_method("remove_all_descendants"):
			child.remove_all_descendants()
		if child.get_parent() == self:
			remove_child(child)
