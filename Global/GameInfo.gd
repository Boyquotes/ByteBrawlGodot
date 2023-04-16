extends Node

const PLAYER_DATA_PATH = "res://Data/PlayerData.json"

var PlayerInstance = load("res://Entities/Player/Player.tscn")

var player: Player

func _ready():
	self.load_player()

func remove_player():
	if self.player:
		self.player.queue_free()
	self.player = null

func load_player():
	self.player = PlayerInstance.instantiate()
	self.player.from_json(load(PLAYER_DATA_PATH).data)

func reload_player():
	self.remove_player()
	self.load_player()


func save_player():
	var file = FileAccess.open(PLAYER_DATA_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(self.player.to_json()))
	file.close()
