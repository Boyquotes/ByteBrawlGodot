class_name PlayerInput

static func get_direction():
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
