class_name FloatParameterField
extends ActionParameterField

var min: float
var max: float

func _init(key: String, type: ActionParameterField.EFieldType, min_value: float, max_value: float):
	super._init(key, type)
	self.min = min_value
	self.max = max_value
