class_name MateriaList

const icon_path = {
	"Fire": "res://Assets/MateriaIcons/icon_21.png",
	"Wind": "res://Assets/MateriaIcons/icon_7.png",
	"Water": "res://Assets/MateriaIcons/icon_26.png",
	"Earth": "res://Assets/MateriaIcons/icon_16.png",
	"Lightning": "res://Assets/MateriaIcons/icon_12.png",
	"Ice": "res://Assets/MateriaIcons/icon_44.png",
	"Wood": "res://Assets/MateriaIcons/icon_19.png",
	"Metal": "res://Assets/MateriaIcons/icon_33.png",
	"Momentum": "res://Assets/MateriaIcons/icon_14.png",
	"Spacium": "res://Assets/MateriaIcons/icon_20.png",
}

static func get_icon_path(type: Materia.EType) -> Texture2D:
	var type_name = Materia.EType.find_key(type)
	return load(icon_path[type_name])
