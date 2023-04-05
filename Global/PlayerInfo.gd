extends Node

var player_data: Dictionary = load("res://Data/PlayerData.json").data
var stances: Dictionary

var selected_stance: String = "normal"
var selected_input: String = "input_1"
var selected_sequence: String = "started_sequence"

var action_list: ActionList

func reload_player_data():
	player_data = load("res://Data/PlayerData.json").data

func get_selected_actions_values() -> Array:
	return player_data[selected_stance]["inputs"][selected_input][selected_sequence]
