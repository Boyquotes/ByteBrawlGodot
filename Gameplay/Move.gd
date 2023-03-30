class_name Move
extends Node

# PUBLIC
@export var speed: float = 64.0


# PRIVATE
var movement_blocked: bool = false


# LIFECYCLE
func _physics_process(delta_time):
	var parent = get_parent()
	
	if not movement_blocked:
		parent.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	parent.move_and_slide()


# LOGIC
func block_movement(value: bool = true):
	self.movement_blocked = value
