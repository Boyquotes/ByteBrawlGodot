class_name LocatorDirection
extends BaseNode2D


var TEXTURE = load("res://Assets/NinjaAdventure/HUD/Kunai.png")
@export var distance: float = 64.0

func _ready():
	name = "target_locator"
	var sprite = Sprite2D.new()
	sprite.texture = TEXTURE
	sprite.rotation_degrees = -130
	add_child(sprite)

func _physics_process(delta_time):
	if not get_parent():
		return
	position = get_target_normalized_from_parent() * distance
	look_at(get_parent().position)

func get_target_normalized_from_parent() -> Vector2:
	return get_parent().position.direction_to(get_global_mouse_position()).normalized()
