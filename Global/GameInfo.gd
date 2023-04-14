extends Node

const PLAYER_DATA_PATH = "res://Data/PlayerData.json"

var PlayerInstance = load("res://Entities/Player/Player.tscn")

var player: Player

func _init():
	self.player = PlayerInstance.instantiate()
	self.load_player()

func load_player():
	self.player.from_json(load(PLAYER_DATA_PATH).data)

func save_player():
	var file = FileAccess.open(PLAYER_DATA_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(self.player.to_json()))
	file.close()
