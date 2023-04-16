class_name LocatorMoveDirection
extends BaseNode2D


var TEXTURE = load("res://Assets/NinjaAdventure/HUD/Kunai.png")
@export var distance: float = 64.0
var sprite: Sprite2D

func _ready():
	name = "target_locator"
	sprite = Sprite2D.new()
	sprite.texture = TEXTURE
	sprite.rotation_degrees = -130
	add_child(sprite)

func _physics_process(delta_time):
	if not get_parent():
		return
	position = get_target_normalized_from_parent() * distance
	sprite.hide() if position.is_zero_approx() else sprite.show()
	look_at(get_parent().position)

func get_target_normalized_from_parent() -> Vector2:
	return PlayerInput.get_direction()
