extends Node2D


var stances: Array[Stance] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	stances = [Stance.new(), Stance.new()]
	change_stance(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta_time):
	pass

func _physics_process(delta_time):
	pass

func change_stance(index: int):
	var selected_stance = stances[index]
	var current_stance = get_node("current_stance") if has_node("current_stance") else null
	if not selected_stance or current_stance == selected_stance: return
	if current_stance:
		current_stance.name = "stance"
		remove_child(current_stance)
	selected_stance.name = "current_stance"
	add_child(selected_stance)
