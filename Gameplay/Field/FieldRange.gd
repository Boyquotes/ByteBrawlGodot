class_name FieldRange
extends Field

var min_value
var max_value
var cost_curve: CostCurve

func get_max_cost():
	return cost_curve.max_value

func get_min_cost():
	return cost_curve.min_value

func get_cost():
	return cost_curve.sample((float(getter.call()) - min_value) / (max_value - min_value))

func _init(id_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	self.min_value = _args[0]
	self.max_value = _args[1]
	self.cost_curve = _args[2]
	super._init(id_name, pretty_name, getter, setter)
