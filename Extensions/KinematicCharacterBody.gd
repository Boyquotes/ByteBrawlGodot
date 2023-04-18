extends CharacterBody2D
class_name KinematicCharacterBody

const fg_dynamic: float = 500
const fg_static: float = 500

@export var mass: float = 1

var acceleration: Vector2 = Vector2.ZERO

func apply_force(force: Vector2):
	self.acceleration += force / mass

func apply_impulse(impulse: Vector2):
	velocity += impulse / mass

func _physics_process(delta_time):
	var is_in_movement: bool = not velocity.is_zero_approx()
	var fg: float = fg_dynamic if is_in_movement else fg_static
	var new_acceleration: Vector2 = Vector2.ZERO
	
	if not acceleration.is_zero_approx() and (is_in_movement or acceleration.length_squared() >= (fg * mass)**2):
		new_acceleration = acceleration
	
	var new_velocity: Vector2 = velocity + (new_acceleration - fg*velocity.normalized()) * delta_time
	
	if new_velocity.dot(velocity) < 0:
		velocity = Vector2.ZERO
	else:
		velocity = new_velocity
	
	move_and_slide()
