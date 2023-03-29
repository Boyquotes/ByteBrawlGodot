class_name Sequence
extends Node

const RESET_STATE = -1

var actions: Array[Action]

var current_action_index: int

func _init():
	pass

func can_be_cast(player: Node):
	for action in actions:
		if not action.can_be_cast(player):
			return false
	return true

func _enter_tree():
	current_action_index = RESET_STATE

func _process(delta):
	if get_child_count() == 0:
		current_action_index += 1
		if not add_action():
			remove_from_parent()

func add_action() -> bool:
	if self.current_action_index >= self.actions.size(): return false
	add_child(actions[self.current_action_index])
	return true

func remove_from_parent():
	get_parent().remove_child(self)

func _to_string() -> String:
	return str(actions)
