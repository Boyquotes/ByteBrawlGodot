extends Area2D
class_name MateriaProjectile

var speed: Vector2
var _owner: KinematicCharacterBody

signal on_hit(body: PhysicsBody2D)

func init(owner: KinematicCharacterBody, position: Vector2, speed: Vector2, life_time: float, size: float, texture: Texture):
	self._owner = owner
	self.position = position
	self.speed = speed
	(get_node("Timer") as Timer).wait_time = life_time
	scale = size * Vector2.ONE
	(get_node("Sprite2D") as Sprite2D).texture = texture

func init_static(owner: KinematicCharacterBody, position: Vector2, life_time: float, size: float, texture: Texture):
	init(owner, position, Vector2.ZERO, life_time, size, texture)

func init_with_offset(owner: KinematicCharacterBody, position: Vector2, offset: float, speed: Vector2, life_time: float, size: float, texture: Texture):
	init(owner, position + offset*speed.normalized(), speed, life_time, size, texture)

func _physics_process(delta_time):
	position += speed * delta_time

func _on_timer_timeout():
	queue_free()

func _on_hit(body: PhysicsBody2D):
	if body == _owner:
		return
	
	on_hit.emit(body)
