class_name ApplyEffectMove
extends ApplyEffectBase

enum EType {
	Pull,
	Push,
	Eject
}

@export var impulse: float = 100.
@export var type: EType = EType.Pull

func _on_hit(owner: Node2D, body: Node2D):
	print(owner, body)
	if body == owner: return
	if not (body is KinematicCharacterBody):
		return
	print("ON_HIT MOVE")
	match type:
		EType.Eject:
			body.apply_impulse(impulse * (body.position - parent.position).normalized())
		EType.Pull:
			body.apply_impulse(impulse * (owner.position - body.position).normalized())
		EType.Push:
			body.apply_impulse(impulse * (body.position - owner.position).normalized())
