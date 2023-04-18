@tool
extends CollisionArea
class_name AreaOfEffect


@onready var sprite: AnimatedSprite2D = AnimatedSprite2D.new()
@onready var life_timer: Timer = Timer.new()
@onready var iframe_timer: Timer = Timer.new()

@export_category("Logic")
@export_group("Hit")
@export var hit_number: float = 1
@export var hit_iframes: float = 0.2:
	get: return iframe_timer.wait_time
	set(x): iframe_timer.wait_time = x
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

signal hit(body: Node2D)
signal on_death(position: Vector2)

func _editor_ready():
	pass

func _ready():
	super._ready()
	if Engine.is_editor_hint(): _editor_ready()
	else: _game_ready()

	self.add_child(self.sprite)
	self.add_child(self.life_timer)
	self.add_child(self.iframe_timer)

# IN GAME

func init(position: Vector2, direction: Vector2 = Vector2.ZERO, offset: float = 0):
	self.position = position + direction.normalized() * offset
	self.velocity = direction.normalized() * speed


func _game_ready():
	self.life_timer.autostart = true
	self.set_hittable(true)
	self.iframe_timer.timeout.connect(self.set_hittable.bind(true))

func set_hittable(hittable: bool):
	if hittable:
		self.body_entered.connect(_hit_process)
	else:
		self.body_entered.disconnect(_hit_process)

func _hit_process(body: Node2D):
	self.set_hittable(false)
	self.hit_number -= 1
	self.hit.emit(body)
	if self.hit_number != 0:
		self.iframe_timer.start()
		return
	self.on_death.emit(self.position)
	self.queue_free()

func _physics_process(delta_time):
	position += velocity * delta_time
