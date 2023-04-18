@tool
extends ApplyEffectBase

enum EMode {
	ON_DEATH,
	ON_HIT,
	EVERYTIME,
}

@export var mode: EMode = EMode.ON_DEATH

func _ready():
	if Engine.is_editor_hint():
		pass
	else:
		pass

func _on_death(owner: Node2D, position: Vector2):
	if [EMode.ON_DEATH, EMode.EVERYTIME].has(self.mode):
		self.spawn_area(owner, position)

func _on_hit(owner: Node2D, _body: Node2D):
	if [EMode.ON_HIT, EMode.EVERYTIME].has(self.mode):
		self.spawn_area(owner, parent.position)

func spawn_area(owner: Node2D, position: Vector2):
	pass
