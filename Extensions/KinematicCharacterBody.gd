extends CharacterBody2D
class_name KinematicCharacterBody

@export var mass: float = 1.

var acceleration: Vector2 = Vector2.ZERO

func apply_force(force: Vector2):
	acceleration += mass * force

func apply_impulse(impulse: Vector2):
	velocity += mass * impulse

func _physics_process(delta_time):
	velocity += acceleration * delta_time
	move_and_slide()
