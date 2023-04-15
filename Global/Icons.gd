extends Node
 
var Icons = load("res://Assets/Icons/icons.tres") as SpriteFrames

func get_texture(name: String, index: int):
	return Icons.get_frame_texture(name, index)

func get_all_textures(name: String) -> Array[Texture2D]:
	var ret: Array[Texture2D] = []
	for i in Icons.get_frame_count(name):
		ret.append(get_texture(name, i))
	return ret
