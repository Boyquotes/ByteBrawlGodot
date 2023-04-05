extends Node

func load_scene(str: String):
	get_tree().change_scene_to_file(str)

func _play():
	load_scene("res://Scenes/Play.tscn")

func _modify_stances():
	load_scene("res://Scenes/InputActionCreationMenu.tscn")

func _option():
	pass
