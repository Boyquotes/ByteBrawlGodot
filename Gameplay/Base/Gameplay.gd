class_name Gameplay
extends Node

var stances: Array[Stance] = []

func _ready():
	stances = [Stance.new(), Stance.new()]
	stances[0].inputs[1].started_sequence.actions.append(ActionDash.new(200.))
	stances[0].inputs[0].started_sequence.actions.append(ActionChangeStance.new(stances[1]))
	stances[1].inputs[1].started_sequence.actions.append(ActionDash.new(1000.))
	stances[1].inputs[0].started_sequence.actions.append(ActionChangeStance.new(stances[0]))
	change_stance(stances[0])

func _process(delta_time):
	pass

func _physics_process(delta_time):
	pass

func change_stance(selected_stance: Stance):
	var current_stance = get_node("stance") if has_node("stance") else null
	if not selected_stance or current_stance == selected_stance: return
	if current_stance:
		current_stance.remove_all_descendants()
		remove_child(current_stance)
	add_child(selected_stance)

