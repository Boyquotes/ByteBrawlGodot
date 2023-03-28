extends Node2D


var stances: Array[Stance]


func _input(event):
	if event.is_action_pressed("input"):
		pass
# Called when the node enters the scene tree for the first time.
func _ready():
	stances = [Stance.new()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta_time):
	pass

func _physics_process(delta_time):
	pass

