class_name FieldDiscrete
extends Field

var cost_discrete: CostDiscrete

func get_cost():
	return cost_discrete.eval(getter.call())

func _init(id_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	self.cost_discrete = _args[0]
	super._init(id_name, pretty_name, getter, setter)
