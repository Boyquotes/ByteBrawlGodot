@tool
extends CollisionArea
class_name AreaOfEffect


var sprite: AnimatedSprite2D = AnimatedSprite2D.new()
var life_timer: Timer = Timer.new()

@export_category("Logic")
@export_group("Hit")
@export var hit_number: float = 1
@export_group("Life")
@export var life_time: float = 1:
	get: return life_timer.wait_time
	set(x): life_timer.wait_time = x
@export_group("Projectile")
@export var speed: float = 0
@export_category("Sprite")
@export var sprite_frames: SpriteFrames:
	get: return sprite.sprite_frames
	set(x): sprite.sprite_frames = x
@export var sprite_animation_name: StringName:
	get: return sprite.animation
	set(x): sprite.animation = x
@export var sprite_animation_frame: float:
	get: return sprite.frame
	set(x): sprite.frame = x
@export var sprite_animation_speed: float = 0:
	get: return sprite.speed_scale
	set(x): sprite.speed_scale = x

var velocity: Vector2
var entity_owner: Node2D
var _spawn_position: Vector2

signal hit(owner: Node2D, body: Node2D)
signal on_death(owner: Node2D, position: Vector2, direction: Vector2)

func _editor_ready():
	pass


func _ready():
	super._ready()
	if Engine.is_editor_hint(): _editor_ready()
	else: _game_ready()

	self.add_child(self.sprite)
	self.add_child(self.life_timer)

# IN GAME

func init(owner: Node2D, _position: Vector2, direction: Vector2 = Vector2.ZERO, offset: float = 0):
	self.entity_owner = owner
	self.velocity = direction.normalized() * speed
	self.position = _position + direction.normalized() * offset

func _game_ready():
	self.life_timer.autostart = true
	self.life_timer.one_shot = true
	self.life_timer.timeout.connect(_on_death)
	self.body_entered.connect(_hit_process)

func _hit_process(body: Node2D):
	if body == entity_owner: return
	self.hit_number -= 1
	self.hit.emit(self.entity_owner, body)
	if self.hit_number == 0:
		self._on_death()

func _on_death():
	print("ONDEATH")
	self.on_death.emit(self.entity_owner, self.position, self.velocity.normalized())
	self.queue_free()

func _physics_process(delta_time):
	position += velocity * delta_time
