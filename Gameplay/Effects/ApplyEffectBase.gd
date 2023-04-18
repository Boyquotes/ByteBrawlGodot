class_name ApplyEffectBase
extends Node

@onready var parent: AreaOfEffect = get_parent()


func _ready():
	parent.hit.connect(_on_hit)
	parent.on_death.connect(_on_death)

func _on_hit(owner: Node2D, body: Node2D):
	pass

func _on_death(owner: Node2D, position: Vector2):
	pass
