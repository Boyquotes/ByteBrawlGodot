extends Node

var materia_frames = load("res://Assets/Icons/icons.tres") as SpriteFrames

const icon_index = {
	"Fire": 21,
	"Wind": 7,
	"Water": 26,
	"Earth": 16,
	"Lightning": 12,
	"Ice": 44,
	"Wood": 19,
	"Metal": 33,
	"Momentum": 14,
	"Spacium": 20,
}

func get_icon_texture(type: Materia.EType) -> Texture2D:
	var type_name = Materia.EType.find_key(type)
	return materia_frames.get_frame_texture("materias", icon_index[type_name])
