class_name EnumParameterField
extends ActionParameterField

var values: Array = []

func _init(key: String, values: Array):
	super._init(key, EFieldType.Choice)
	self.values = values
