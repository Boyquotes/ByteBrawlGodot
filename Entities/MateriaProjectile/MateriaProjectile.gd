extends Area2D
class_name MateriaProjectile

var speed: Vector2

func _ready():
	print("awd")

func init(on_hit: Callable, speed: Vector2, life_time: float, size: float, texture: Texture):
	body_entered.connect(on_hit)
	self.speed = speed
	(get_node("Timer") as Timer).wait_time = life_time
	scale = size * Vector2.ONE
	(get_node("Sprite2D") as Sprite2D).texture = texture

func _physics_process(delta_time):
	position += speed * delta_time

func _on_timer_timeout():
	queue_free()
