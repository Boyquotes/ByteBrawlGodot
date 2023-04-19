class_name Move
extends Node

# PUBLIC
@export var speed: float = 100.0
@export var acceleration_force: float = 1000.

# PRIVATE
var movement_blocked: bool = false
var player: Player

func _ready():
	player = get_parent()

# LIFECYCLE
func _physics_process(delta_time):
	if not movement_blocked:
		player.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

# LOGIC
func block_movement(value: bool = true):
	self.movement_blocked = value
