class_name CostDiscrete

var values: Dictionary
var min_value: float
var max_value: float

func eval(x):
	return values[x]

func _init(values: Dictionary):
	self.values = values
	self.min_value = values.values().min()
	self.max_value = values.values().max()

static func init_same_values(keys: Array, value: float, other_values: Dictionary = {}):
	var values = {}
	
	for key in keys:
		values[key] = value
	
	for key in other_values:
		values[key] = other_values[key]
	
	return CostDiscrete.new(values)
