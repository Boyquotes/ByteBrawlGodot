extends Node2D

@export var speed : float = 64.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta_time):
	var parent = get_parent()
	
	parent.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	parent.move_and_slide()
