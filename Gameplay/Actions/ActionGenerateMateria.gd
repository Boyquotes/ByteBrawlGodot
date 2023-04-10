class_name ActionGenerateMateria
extends Action

var PLAYER_STAT_GENERATION_MATERIA = 1.

var materia: Materia

func _init(materia: Materia):
	self.materia = materia
	self.duration = PLAYER_STAT_GENERATION_MATERIA * materia.generation_time_customer
	self.allowed_sequence = [Sequence.EType.Start, Sequence.EType.Press]

func activate():
	pass

func done():
	if _owner_materia_pool:
		_owner_materia_pool.addMateria(materia.clone())
		pass

# UI HELPER
static func get_default_values() -> Dictionary:
	return { "materia_type": "Fire" }
	
static func new_from_editor(values: Dictionary):
	return ActionGenerateMateria.new(Materia.new(Materia.EType.get(values["materia_type"])))


func get_variables_to_set() -> Array[Field]:
	var materia_type_keys = Materia.EType.keys()
	return [
		ActionsInfo.Enum(
			"materia_type",
			"Materia Type",
			func(): return materia_type_keys[materia.type],
			func(x): materia.queue_free(); materia = Materia.new(Materia.EType.get(x)),
			materia_type_keys
		)
	]
