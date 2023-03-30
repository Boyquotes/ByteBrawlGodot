class_name Gameplay
extends Node

var stances: Array[Stance] = []

func _ready():
	stances = [Stance.new(), Stance.new()]
	change_stance(stances[0])
	stances[0].inputs[1].started_sequence.actions.append(ActionDash.new(400.))

func _process(delta_time):
	pass

func _physics_process(delta_time):
	pass

func change_stance(selected_stance: Stance):
	var current_stance = get_node("stance") if has_node("stance") else null
	if not selected_stance or current_stance == selected_stance: return
	if current_stance: remove_child(current_stance)
	add_child(selected_stance)

