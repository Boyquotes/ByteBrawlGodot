class_name EjectProjectile
extends Node

enum EType {
	Pull,
	Push,
	Eject
}

@onready var area: MateriaProjectile = get_parent()
@export var impulse: float
@export var type: EType

func _ready():
	area.on_hit.connect(_on_hit)

func _on_hit(body: PhysicsBody2D):
	if body is KinematicCharacterBody:
		if type == EType.Eject:
			body.apply_impulse(impulse * (body.position - area.position).normalized())
		elif type == EType.Pull:
			body.apply_impulse(impulse * (area._owner.position - body.position).normalized())
		elif type == EType.Push:
			body.apply_impulse(impulse * (body.position - area._owner.position).normalized())
