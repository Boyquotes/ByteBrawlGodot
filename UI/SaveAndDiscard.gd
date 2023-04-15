extends Node

func reload_menu_scene():
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")

func _save():
	GameInfo.save_player()
	reload_menu_scene()

func _discard():
	GameInfo.reload_player()
	reload_menu_scene()
