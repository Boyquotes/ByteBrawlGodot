extends Node

func load_scene(scene_path: String):
	get_tree().change_scene_to_file(scene_path)

func _play():
	load_scene("res://Scenes/Play.tscn")

func _modify_stances():
	load_scene("res://Scenes/InputActionCreationMenu.tscn")

func _option():
	pass
