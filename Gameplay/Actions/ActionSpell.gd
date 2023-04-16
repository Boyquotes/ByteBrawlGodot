extends Action
class_name ActionSpell

enum EMode {
	OneTime,
	Repeat,
	DrainAll
}

var materia_type: Materia.EType
var drain_mode: EMode

var quantity_to_drain_max: int = 50.
var quantity_to_drain_min: int = 0.
var quantity_to_drain: int:
	set(x): quantity_to_drain = clampi(x, quantity_to_drain_min, quantity_to_drain_max) 

func init_fields():
	super.init_fields()
	
	var materia_type_keys = Materia.EType.keys()
	var mode_keys = EMode.keys()
	fields.append_array([
		Field.Enum(
			"materia_type",
			"Materia Type",
			func(): return materia_type_keys[materia_type],
			func(x): materia_type = Materia.EType.get(x),
			CostDiscrete.init_same_values(materia_type_keys, 1.)
		),
		Field.Enum(
			"drain_mode",
			"Drain Mode",
			func(): return mode_keys[drain_mode],
			func(x): drain_mode = EMode.get(x),
			CostDiscrete.new({"OneTime": 1., "Repeat": 10., "DrainAll": 5.})
		),
		Field.Int(
			"quantity_to_drain",
			"Quantity to Drain",
			func(): return quantity_to_drain,
			func(x): quantity_to_drain = x,
			quantity_to_drain_min,
			quantity_to_drain_max,
			CostCurve.new(1., 20., CostCurve.EMode.Exponential)
		)
	])
