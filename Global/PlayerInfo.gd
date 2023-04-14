extends Node

var selected_stance: String = "normal"
var selected_input: int = 0
var selected_sequence: String = "started_sequence"

var action_list: ActionList
var action_selector: ActionSelector

func get_selected_sequence_type() -> Sequence.EType:
	return Sequence.EType.get(selected_sequence)

func get_selected_actions_values() -> Array:
	return player_data[selected_stance]["inputs"][selected_input][selected_sequence]
