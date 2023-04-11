extends Node

var player_data: Dictionary = load("res://Data/PlayerData.json").data

var selected_stance: String = "normal"
var selected_input: int = 0
var selected_sequence: String = "started_sequence"

var action_list: ActionList
var action_selector: ActionSelector

var stances: Dictionary

func _init():
	init_stances()

func init_stances():
	for stance_name in player_data:
		var new_stance: Stance = Stance.new(stance_name)
		stances[stance_name] = new_stance
		
		var inputs_info: Array = player_data[stance_name]["inputs"]

		for i in inputs_info.size():
			for sequence_name in inputs_info[i]:
				for action_info in inputs_info[i][sequence_name]:
					var action_type = ActionsInfo.actions.filter(func (x): return x.display_name == action_info["name"])[0]
					new_stance.inputs[i].get(sequence_name).actions.append(action_type.new_from_editor(action_info["values"]))

func reload_player_data():
	player_data = load("res://Data/PlayerData.json").data

func get_selected_sequence_type() -> Sequence.EType:
	return Sequence.EType.get(selected_sequence)

func get_selected_actions_values() -> Array:
	return player_data[selected_stance]["inputs"][selected_input][selected_sequence]
