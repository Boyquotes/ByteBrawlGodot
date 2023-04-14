class_name ActionGenerateMateria
extends Action

const PLAYER_STAT_GENERATION_MATERIA = 1.
const materia_life_time_min: float = .2
const materia_life_time_max: float = 10.
const generation_time_customer_min: float = .2
const generation_time_customer_max: float = 4.

var materia: Materia
var _generation_time_customer: float = 1.
var generation_time_customer:
	set(x): _generation_time_customer = x; duration = PLAYER_STAT_GENERATION_MATERIA * x

const allowed_sequence = [Sequence.EType.started_sequence, Sequence.EType.pressed_sequence]
const display_name = "GenerateMateria"


func _init(materia: Materia, generation_time_customer: float):
	self.materia = materia
	self.generation_time_customer = generation_time_customer

func activate():
	pass

func done():
	if _owner_materia_pool:
		_owner_materia_pool.add_materia(materia.clone())
		pass

# UI HELPER
func get_display_name():
	return self.display_name

static func get_default_values() -> Dictionary:
	return { "materia_type": "Fire", "materia_life_time": 4., "generation_time_customer": 1. }

func to_json():
	return {
		"name": display_name,
		"values": {
		}
	}

static func new_from_json(values: Dictionary):
	return ActionGenerateMateria.new(Materia.new(Materia.EType.get(values["materia_type"]), values["materia_life_time"]), values["generation_time_customer"])


func set_fields() -> Array[Field]:
	var materia_type_keys = Materia.EType.keys()
	return [
		ActionsInfo.Enum(
			"materia_type",
			"Materia Type",
			func(): return materia_type_keys[materia.type],
			func(x): materia.type = Materia.EType.get(x),
			CostDiscrete.init_same_values(materia_type_keys, 1., {"Ice": 2.})
		),
		ActionsInfo.Float(
			"materia_life_time",
			"Materia life time",
			func(): return materia.life_time,
			func(x): materia.life_time = x,
			materia_life_time_min,
			materia_life_time_max,
			CostCurve.new(.1, 10., CostCurve.EMode.Exponential)
		),
		ActionsInfo.Float(
			"generation_time_customer",
			"Generation Time Customer",
			func(): return _generation_time_customer,
			func(x): generation_time_customer = x,
			generation_time_customer_min,
			generation_time_customer_max,
			CostCurve.new(.1, 10., CostCurve.EMode.Exponential)
		)
	]
