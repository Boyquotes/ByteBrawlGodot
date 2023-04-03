class_name LocatorPosition
extends BaseNode2D

var TEXTURE = load("res://Assets/NinjaAdventure/HUD/Kunai.png")

var distance: float

func _init(distance: float = 256.0):
	self.distance = distance

func _ready():
	name = "target_locator"
	position = get_target_position_in_range()
	var sprite = Sprite2D.new()
	sprite.texture = TEXTURE
	sprite.rotation_degrees = 90
	sprite.position = Vector2(-12, -12)
	add_child(sprite)

func _physics_process(delta_time):
	if not get_parent():
		return
	position = get_target_position_in_range()

func get_target_position_in_range() -> Vector2:
	var position = (get_parent() as Node2D).get_local_mouse_position()
	if position.length_squared() <= distance ** 2:
		return position
	return position.normalized() * distance
