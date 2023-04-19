@tool
class_name KinematicCharacterBody
extends RigidBody2D

const fg: float = 500.

var collision: CollisionShape2D = CollisionShape2D.new()

@export_group("Physic")

@export var max_speed: float = 100.
@export var movement_force: float = 1000.

@export_group("Shape")
@export var shape_type = CollisionArea.EShapeType.circle:
	set(x):
		shape_type = x;
		notify_property_list_changed();
		self.switch_shape()

var shape_radius: float = 16
var shape_extents = Vector2(16, 16)

# EDITOR LOGIC
func _set(property, value):
	if not collision.shape:
		self.switch_shape()
	match property:
		"Shape/shape_radius":
			shape_radius = value
			(collision.shape as CircleShape2D).radius = value
			return true
		"Shape/shape_extents":
			shape_extents = value
			(collision.shape as RectangleShape2D).extents = value
			return true
	return false

func _get(property):
	match property:
		"Shape/shape_radius": return shape_radius
		"Shape/shape_extents": return shape_extents

@export_group("")
func _get_property_list() -> Array:
	var props = []
	match shape_type:
		CollisionArea.EShapeType.circle:
			props.push_back({ name = "Shape/shape_radius", type = TYPE_INT })
		CollisionArea.EShapeType.rectangle:
			props.push_back({ name = "Shape/shape_extents", type = TYPE_VECTOR2 })
	return props

func switch_shape():
	match shape_type:
		CollisionArea.EShapeType.circle:
			self.collision.shape = CircleShape2D.new()
			self.collision.shape.radius = shape_radius
		CollisionArea.EShapeType.rectangle:
			self.collision.shape = RectangleShape2D.new()
			self.collision.shape.extents = shape_extents

func _editor_ready():
	lock_rotation = true

func _editor_physic_process(delta_time):
	pass

func _ready():
	add_child(self.collision)
	if not collision.shape:
		self.switch_shape()
	if Engine.is_editor_hint(): _editor_ready()
	else: _game_ready()

func _physics_process(delta_time):
	if Engine.is_editor_hint(): _editor_physic_process(delta_time)
	else: _game_physic_process(delta_time)

# PHYSICS LOGIC
var direction: Vector2 = Vector2.ZERO
var bodies_calc_already_done: Array[PhysicsBody2D] = []

func _game_ready():
	pass

func _game_physic_process(delta_time):
	var force: Vector2 = movement_force * (Vector2.ZERO if direction.is_zero_approx() else direction.normalized())
	var new_velocity: Vector2 = linear_velocity + delta_time / mass * force
	
	if new_velocity.length_squared() <= max_speed**2:
		apply_central_force(force)

func _integrate_forces(state):
	var current_direction: Vector2 = linear_velocity.normalized()
	
	var new_velocity = linear_velocity - fg*current_direction*state.step*state.inverse_mass
	if linear_velocity.dot(new_velocity) >= 0:
		linear_velocity = new_velocity
	else:
		linear_velocity = Vector2.ZERO
