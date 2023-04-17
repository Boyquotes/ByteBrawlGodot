extends CharacterBody2D
class_name KinematicCharacterBody

@export var mass: float = 1.

var forces: Array[Vector2] = []

func add_force(force: Vector2):
	forces.append(force)

func _physics_process(delta_time):
	var acceleration = forces.reduce(func(force, acc): acc += force * mass)
	velocity += acceleration * delta_time
