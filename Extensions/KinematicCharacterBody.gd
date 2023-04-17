extends CharacterBody2D
class_name KinematicCharacterBody

const g: float = 9.81
const f_d: float = .8
const f_s: float = 1.

@export var mass: float = 1.

var acceleration: Vector2 = Vector2.ZERO

func apply_force(force: Vector2):
	acceleration += mass * force

func apply_impulse(impulse: Vector2):
	velocity += mass * impulse

func _physics_process(delta_time):
	var f: float = f_s if velocity.is_zero_approx() else f_d
	
	if acceleration.length_squared() >= (f * g)**2:
		velocity += (acceleration - f*g*velocity.normalized()) * delta_time
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
