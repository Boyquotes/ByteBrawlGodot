extends Node
class_name MateriaList

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

static func get_icon_texture(type: Materia.EType) -> Texture2D:
	var type_name = Materia.EType.find_key(type)
	return Icons.get_texture("materias", icon_index[type_name])
