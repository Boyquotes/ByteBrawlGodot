class_name EntityStats
extends Node

signal on_death
signal on_health_changed(old_hp, new_hp)

@export var max_hp: float = 100.
@onready var hp: float = max_hp:
	set(x):
		var new_hp = clamp(x, 0, max_hp)
		if hp != new_hp:
			on_health_changed.emit(hp, new_hp)
			hp = new_hp
		if hp <= 0:
			on_death.emit()

func _ready():
	on_death.connect(_on_death)

func _on_death():
	get_parent().queue_free()

