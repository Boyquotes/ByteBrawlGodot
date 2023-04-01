class_name LocatorDirection
extends BaseNode2D


var TEXTURE = load("res://Assets/NinjaAdventure/HUD/Kunai.png")
@export var distance: float = 64.0


var target: Vector2 = Vector2.ZERO

func _ready():
	name = "target_locator"
	var sprite = Sprite2D.new()
	sprite.texture = TEXTURE
	sprite.rotation_degrees = -130
	add_child(sprite)

func _input(event):
	if event is InputEventMouseMotion:
		save_position_from_event(event)

func _physics_process(delta_time):
	if target == Vector2.ZERO or not get_parent():
		return
	position = get_target_normalized_from_parent() * distance
	look_at(get_parent().position)

func save_position_from_event(event: InputEventMouseMotion):
	target = event.position

func get_target_normalized_from_parent() -> Vector2:
	return get_parent().get_global_transform_with_canvas().origin.direction_to(target).normalized()
