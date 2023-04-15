class_name ActionGenerateMateria
extends Action

const PLAYER_STAT_GENERATION_MATERIA = 1.
const materia_life_time_min: float = .2
const materia_life_time_max: float = 10.
const generation_time_customer_min: float = .2
const generation_time_customer_max: float = 4.

var materia: Materia = Materia.new(Materia.EType.Fire)
var _generation_time_customer: float
var generation_time_customer:
	set(x): _generation_time_customer = x; duration = PLAYER_STAT_GENERATION_MATERIA * x

const allowed_sequence = [Sequence.EType.started_sequence, Sequence.EType.pressed_sequence]
const action_name = "GenerateMateria"

func _init():
	self.type = EType.generateMateria
	self.generation_time_customer = 1
	super._init()

func activate():
	pass

func done():
	if _owner.materia_pool:
		_owner.materia_pool.add_materia(materia.clone())
		pass

# UI HELPER
func get_fields() -> Array[Field]:
	var materia_type_keys = Materia.EType.keys()
	return [
		Field.Enum(
			"materia_type",
			"Materia Type",
			func(): return materia_type_keys[materia.type],
			func(x): materia.type = Materia.EType.get(x),
			CostDiscrete.init_same_values(materia_type_keys, 1., {"Ice": 2.})
		),
		Field.Float(
			"materia_life_time",
			"Materia life time",
			func(): return materia.life_time,
			func(x): materia.life_time = x,
			materia_life_time_min,
			materia_life_time_max,
			CostCurve.new(.1, 10., CostCurve.EMode.Exponential)
		),
		Field.Float(
			"generation_time_customer",
			"Generation Time Customer",
			func(): return _generation_time_customer,
			func(x): generation_time_customer = x,
			generation_time_customer_min,
			generation_time_customer_max,
			CostCurve.new(.1, 10., CostCurve.EMode.Exponential)
		)
	]
