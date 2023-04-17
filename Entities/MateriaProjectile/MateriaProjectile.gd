extends Area2D
class_name MateriaProjectile

var speed: Vector2

func init(position: Vector2, speed: Vector2, life_time: float, size: float, texture: Texture):
	self.position = position
	self.speed = speed
	(get_node("Timer") as Timer).wait_time = life_time
	scale = size * Vector2.ONE
	(get_node("Sprite2D") as Sprite2D).texture = texture

func init_static(position: Vector2, life_time: float, size: float, texture: Texture):
	init(position, Vector2.ZERO, life_time, size, texture)

func init_with_offset(position: Vector2, offset: float, speed: Vector2, life_time: float, size: float, texture: Texture):
	init(position + offset*speed.normalized(), speed, life_time, size, texture)

func _physics_process(delta_time):
	position += speed * delta_time

func _on_timer_timeout():
	queue_free()
