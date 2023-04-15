extends Node

var materia_frames = load("res://Assets/Icons/icons.tres") as SpriteFrames

const icon_index = {
	"Fire": 20,
	"Wind": 6,
	"Water": 25,
	"Earth": 15,
	"Lightning": 11,
	"Ice": 43,
	"Wood": 18,
	"Metal": 32,
	"Momentum": 13,
	"Spacium": 19,
}

func get_icon_texture(type: Materia.EType) -> Texture2D:
	var type_name = Materia.EType.find_key(type)
	return materia_frames.get_frame_texture("materias", icon_index[type_name])
