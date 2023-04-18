class_name ApplyEffectDamage
extends ApplyEffectBase

@export var damage: float = 0.

func _on_hit(owner: Node2D, body: Node2D):
	if not (body is KinematicCharacterBody):
		return
	
	var entity_stats: EntityStats = body.get_node("EntityStats")
	if entity_stats == null:
		return
	
	entity_stats.hp -= damage
