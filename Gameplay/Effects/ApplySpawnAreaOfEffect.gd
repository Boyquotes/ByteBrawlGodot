class_name ApplySpawnAreaOfEffect
extends ApplyEffectBase

enum EMode {
	ON_DEATH,
	ON_HIT,
	EVERYTIME,
}

@export var mode: EMode = EMode.ON_DEATH
@export_global_file("*.tscn") var entity_to_spawn: String
@onready var entity = load(entity_to_spawn)
@export_range(-180, 180) var angle: float = 0.0


func _ready():
	super._ready()

func _on_death(owner: Node2D, position: Vector2, direction: Vector2):
	if [EMode.ON_DEATH, EMode.EVERYTIME].has(self.mode):
		self.spawn_area(owner, position, direction, true)
	self.queue_free()

func _on_hit(owner: Node2D, _body: Node2D):
	if [EMode.ON_HIT, EMode.EVERYTIME].has(self.mode):
		self.spawn_area(owner, parent.position, parent.velocity.normalized(), false)

func spawn_area(owner: Node2D, position: Vector2, direction: Vector2, last: bool):
	var new_entity: AreaOfEffect = entity.instantiate()
	new_entity.init(owner, position, Vector2.from_angle(direction.angle() + (angle / 180) * PI))
	get_node("/root").add_child(new_entity)
