class_name EntityStats
extends Node

@export var max_hp: float = 100.
@onready var hp: float = max_hp:
	set(x): hp = clamp(x, 0, max_hp)
