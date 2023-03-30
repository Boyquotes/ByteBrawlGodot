class_name Sequence
extends BaseNode


# UTILS
const RESET_STATE = -1


# PUBLIC
var actions: Array[Action]


# PRIVATE
var current_action_index: int


# LIFECYCLE
func _init():
	pass

func _enter_tree():
	current_action_index = RESET_STATE

func _process(delta):
	if has_child(): return
	current_action_index += 1
	if not add_action():
		remove_from_parent()


# LOGIC
func add_action() -> bool:
	if self.current_action_index >= self.actions.size(): return false
	add_child(actions[self.current_action_index])
	return true

func can_be_cast():
	for action in actions:
		if not action.can_be_cast():
			return false
	return true


# DEBUG
func _to_string() -> String:
	return str(actions)
