class_name Gameplay
extends Node

var stances: Array[Stance] = []

var action_blocked: bool = false

func _ready():
	stances = [Stance.new(), Stance.new()]
	stances[0].inputs[1].started_sequence.actions.append(ActionDash.new(200.))
	stances[0].inputs[0].started_sequence.actions.append(ActionChangeStance.new(stances[1]))
	stances[0].inputs[2].started_sequence.actions.append(ActionSwitchTargetMode.new(ActionSwitchTargetMode.ETargetType.Direction))
	stances[0].inputs[2].released_sequence.actions.append(ActionSwitchTargetMode.new(ActionSwitchTargetMode.ETargetType.None))
	stances[1].inputs[1].started_sequence.actions.append(ActionDash.new(1000.))
	stances[1].inputs[0].started_sequence.actions.append(ActionChangeStance.new(stances[0]))
	change_stance(stances[0])

 # LOGIC
func _input(event):
	var input = PlayerInput.get_input_type(event)
	if not input: return
	if input.type == PlayerInput.EInputType.Press: return active_input(input.key)
	if input.type == PlayerInput.EInputType.Release: return deactive_input(input.key)

func _process(delta_time):
	pass

func _physics_process(delta_time):
	pass

func get_stance():
	return get_node("stance") if has_node("stance") else null

func change_stance(selected_stance: Stance):
	var current_stance = get_stance()
	if not selected_stance or current_stance == selected_stance: return
	if current_stance:
		current_stance.remove_all_descendants()
		remove_child(current_stance)
	add_child(selected_stance)

func active_input(index: int):
	var stance = get_stance()
	if not stance or index == -1 or stance.inputs[index].get_parent() == stance: return
	stance.add_child(stance.inputs[index])

func deactive_input(index: int):
	var stance = get_stance()
	if not stance or index == -1 or stance.inputs[index].get_parent() != stance: return
	stance.inputs[index].stop()

func block_action(value: bool):
	self.action_blocked = value

