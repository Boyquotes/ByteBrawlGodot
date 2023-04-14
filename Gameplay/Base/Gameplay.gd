class_name Gameplay
extends Node


var action_blocked: bool = false
var stances: Array[Stance] = []
var current_stance: Stance:
	get: return get_node("stance") if has_node("stance") else null

func _ready():
	var stance = self.get_stance("normal")
	if stance:
		change_stance(stance)

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

func change_stance(selected_stance: Stance):
	if not selected_stance or current_stance == selected_stance: return
	if current_stance:
		current_stance.remove_all_descendants()
		remove_child(current_stance)
	add_child(selected_stance)

func active_input(index: int):
	if not current_stance or index == -1 or current_stance.inputs[index].get_parent() == current_stance: return
	current_stance.add_child(current_stance.inputs[index])

func deactive_input(index: int):
	if not current_stance or index == -1 or current_stance.inputs[index].get_parent() != current_stance: return
	current_stance.inputs[index].stop()

func block_action(value: bool):
	self.action_blocked = value

func get_stance(stance_name: String) -> Stance:
	var stances = self.stances.filter(func(x): return x.stance_name == stance_name)
	return null if stances.size() == 0 else stances[0]

# UI HELPER
func to_json():
	return {
		"stances": self.stances.map(func(x): return x.to_json())
	}

func from_json(data: Dictionary):
	for stance in data.stances:
		stances.append(Stance.new(stance.name))
	for key in self.stances.size():
		stances[key].from_json(data.stances[key])


