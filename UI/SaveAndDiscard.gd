extends Node

func reload_menu_scene():
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")

func _save():
	var file = FileAccess.open("res://Data/PlayerData.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(PlayerInfo.player_data))
	file.close()
	reload_menu_scene()

func _discard():
	PlayerInfo.reload_player_data()
	reload_menu_scene()
