extends Node2D


var stances: Array[Stance] = []

var current_stance_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	stances = [Stance.new()]
	change_stance(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta_time):
	pass

func _physics_process(delta_time):
	pass

func change_stance(index: int):
	current_stance_index = index
	for stance_index in stances.size():
		stances[stance_index].is_active = stance_index == index
		
