class_name Player
extends CharacterBody2D

var stances: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	stances = {"normal": Stance.new(), "scoping": Stance.new()}
	change_stance("normal")
	stances["normal"].inputs["input_1"].started_sequence.actions.append(ActionDash.new(400.))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta_time):
	pass

func _physics_process(delta_time):
	pass

func change_stance(stance_name: String):
	var selected_stance = stances[stance_name]
	var current_stance = get_node("current_stance") if has_node("current_stance") else null
	if not selected_stance or current_stance == selected_stance: return
	if current_stance:
		current_stance.name = "stance"
		remove_child(current_stance)
	selected_stance.name = "current_stance"
	add_child(selected_stance)
