@tool
class_name ApplySpawnAreaOfEffect
extends ApplyEffectBase

enum EMode {
	ON_DEATH,
	ON_HIT,
	EVERYTIME,
}

var area_of_effect: AreaOfEffect = AreaOfEffect.new()

@export var mode: EMode = EMode.ON_DEATH

func _ready():
	super._ready()
	if Engine.is_editor_hint():
		self.area_of_effect.name = "AreaOfEffect"
		self.add_child(self.area_of_effect)
		self.area_of_effect.set_owner(get_tree().edited_scene_root)
	else:
		self.area_of_effect = get_node("AreaOfEffect")
		self.remove_child(self.area_of_effect)

func _on_death(owner: Node2D, position: Vector2, direction: Vector2):
	if [EMode.ON_DEATH, EMode.EVERYTIME].has(self.mode):
		self.spawn_area(owner, position, direction, true)
	self.queue_free()

func _on_hit(owner: Node2D, _body: Node2D):
	pass
#	if [EMode.ON_HIT, EMode.EVERYTIME].has(self.mode):
#		self.spawn_area(owner, parent.position, parent.velocity.normalized(), false)

func spawn_area(owner: Node2D, position: Vector2, direction: Vector2, last: bool):
	var new_area: AreaOfEffect = area_of_effect.duplicate() if not last else area_of_effect
	print(new_area.get_property_list())
	new_area.init(owner, position, direction)
	get_node("/root").add_child(area_of_effect)
