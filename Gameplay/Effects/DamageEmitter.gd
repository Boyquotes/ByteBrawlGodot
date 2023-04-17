@tool
class_name DamageEmitter
extends Area2D

enum EShapeType {
	circle,
	rectangle,
}

var collision: CollisionShape2D = CollisionShape2D.new()

@export_group("Shape")
@export var shape_type = EShapeType.rectangle:
	set(x):
		shape_type = x;
		notify_property_list_changed();
		self.switch_shape()
var shape_radius: float = 16
var shape_extents = Vector2(16, 16)

# EDITOR LOGIC
func _set(property, value):
	match property:
		"Shape/shape_radius":
			shape_radius = value
			(collision.shape as CircleShape2D).radius = value
		"Shape/shape_extents":
			shape_extents = value
			(collision.shape as RectangleShape2D).extents = value
	return true

func _get(property):
	match property:
		"Shape/shape_radius": return shape_radius
		"Shape/shape_extents": return shape_extents

@export_group("")
func _get_property_list() -> Array:
	var props = []
	match shape_type:
		EShapeType.circle:
			props.push_back({ name = "Shape/shape_radius", type = TYPE_INT })
		EShapeType.rectangle:
			props.push_back({ name = "Shape/shape_extents", type = TYPE_VECTOR2 })
	return props

func add_child_and_show(node: Node):
	add_child(node)
	node.set_owner(get_tree().edited_scene_root)

func switch_shape():
	match shape_type:
		EShapeType.circle:
			self.collision.shape = CircleShape2D.new()
			self.collision.shape.radius = shape_radius
		EShapeType.rectangle:
			self.collision.shape = RectangleShape2D.new()
			self.collision.shape.extents = shape_extents


##############
#            #
# GAME LOGIC #
#            #
##############

var damage: Damage

func _init():
	pass

func _ready():
	self.collision.name = "collision"
	self.switch_shape()
	self.body_entered.connect(_on_collide)
	add_child(self.collision)
	self.queue_free()

func _on_collide(body):
	pass #EMIT DAMAGE

func _process(delta):
	pass
