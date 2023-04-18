@tool
class_name KinematicCharacterBody
extends CharacterBody2D

const fg_dynamic: float = 500
const fg_static: float = 500

var collision: CollisionShape2D = CollisionShape2D.new()
var collision_area: CollisionArea = CollisionArea.new()

const SIZE_DIFF: float = 2

@export_group("Logic")
@export var mass: float = 1

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
			(collision_area.collision.shape as CircleShape2D).radius = value + SIZE_DIFF
			return true
		"Shape/shape_extents":
			shape_extents = value
			(collision.shape as RectangleShape2D).extents = value
			(collision_area.collision.shape as RectangleShape2D).extents = value + (Vector2.ONE * SIZE_DIFF)
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
		collision_area.EShapeType.circle:
			props.push_back({ name = "Shape/shape_radius", type = TYPE_INT })
		collision_area.EShapeType.rectangle:
			props.push_back({ name = "Shape/shape_extents", type = TYPE_VECTOR2 })
	return props

func switch_shape():
	match shape_type:
		collision_area.EShapeType.circle:
			self.collision.shape = CircleShape2D.new()
			self.collision.shape.radius = shape_radius
			self.collision_area.collision.shape = CircleShape2D.new()
			self.collision.shape.radius = shape_radius + SIZE_DIFF
		collision_area.EShapeType.rectangle:
			self.collision.shape = RectangleShape2D.new()
			self.collision.shape.extents = shape_extents
			self.collision_area.collision.shape = RectangleShape2D.new()
			self.collision_area.collision.shape.extents = shape_extents + (Vector2.ONE * SIZE_DIFF)

func _editor_ready():
	pass

func _ready():
	add_child(self.collision)
	add_child(self.collision_area)
	if not collision.shape:
		self.switch_shape()
	if Engine.is_editor_hint(): _editor_ready()
	else: _game_ready()

# PHYSICS LOGIC
var acceleration: Vector2 = Vector2.ZERO
var bodies_calc_already_done: Array[PhysicsBody2D] = []

func _game_ready():
	collision_area.body_entered.connect(_on_body_entered)

func apply_force(force: Vector2):
	self.acceleration += force / mass

func apply_impulse(impulse: Vector2):
	velocity += impulse / mass

func calc_new_velocity(v1: Vector2, v2: Vector2, m1: float, m2: float, e: float = 5/9):
	return (m1 / (m1 + m2)) * (1 + e) * v1 + (m2 / (m1 + m2)) * (1 - e) * v2

func _on_body_entered(body: PhysicsBody2D):
	if not body is KinematicCharacterBody or body == self:
		return
	if body in bodies_calc_already_done:
		bodies_calc_already_done.erase(body)
		return

	var old_velocity: Vector2 = velocity
	self.velocity = calc_new_velocity(velocity, body.velocity, mass, body.mass)
	body.velocity = calc_new_velocity(body.velocity, old_velocity, body.mass, mass)
	
	body.bodies_calc_already_done.append(self)

func set_movement(delta_time):
	var is_in_movement: bool = not velocity.is_zero_approx()
	var fg: float = fg_dynamic if is_in_movement else fg_static
	var new_acceleration: Vector2 = Vector2.ZERO
	
	if not acceleration.is_zero_approx() and (is_in_movement or acceleration.length_squared() >= (fg * mass)**2):
		new_acceleration = acceleration
	
	var new_velocity: Vector2 = velocity + (new_acceleration - fg*velocity.normalized()) * delta_time
	
	if new_velocity.dot(velocity) < 0:
		velocity = Vector2.ZERO
	else:
		velocity = new_velocity

func _physics_process(delta_time):
	set_movement(delta_time)
	move_and_slide()
