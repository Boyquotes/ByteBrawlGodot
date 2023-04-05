extends Node

var player_data: JSON = load("res://Data/PlayerData.json")
var stances: Dictionary

var selected_stance: String = "normal"
var selected_input: String = "input_1"
var selected_sequence: String = "started_sequence"

var action_list: ActionList

func _init():
	stances = player_data.data["stances"]

func get_selected_actions_values() -> Array:
	return stances[selected_stance]["inputs"][selected_input][selected_sequence]
