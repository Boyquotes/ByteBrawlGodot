class_name ActionSwitchTargetMode
extends Action

var PLAYER_STAT_GENERATION_MATERIA = 1.

var materia: Materia

func _init(materia: Materia):
	self.materia = materia
	self.duration = PLAYER_STAT_GENERATION_MATERIA * materia.generation_time_customer

func activate():
	pass

func done():
	if _owner_materia_pool:
		_owner_materia_pool.addMateria(materia.clone())
		pass

# UI HELPER
func get_variables_to_set() -> Array[ActionParameterField]:
	return [
		# EnumParameterField.new("target_type", [ ETargetType.Direction, ETargetType.Position ])
	]
