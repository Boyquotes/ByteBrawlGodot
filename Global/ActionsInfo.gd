extends Node

var actions: Array = [
	ActionDash,
	ActionChangeStance,
	ActionSwitchTargetMode,
	ActionThrow,
	ActionGenerateMateria,
]

var field_bool = load("res://UI/InputType/FieldBool.tscn")
var field_int = load("res://UI/InputType/FieldInt.tscn")
var field_float = load("res://UI/InputType/FieldFloat.tscn")
var field_enum = load("res://UI/InputType/FieldEnum.tscn")

func Bool(id_name: String, pretty_name: String, getter: Callable, setter: Callable):
	var field: FieldBool = field_bool.instantiate()
	field.init(id_name, pretty_name, getter, setter)
	return field

func Int(id_name: String, pretty_name: String, getter: Callable, setter: Callable, min: int, max: int, cost_curve: CostCurve):
	var field: FieldInt = field_int.instantiate()
	field.init(id_name, pretty_name, getter, setter, [min, max, cost_curve])
	return field

func Float(id_name: String, pretty_name: String, getter: Callable, setter: Callable, min: float, max: float, cost_curve: CostCurve):
	var field: FieldFloat = field_float.instantiate()
	field.init(id_name, pretty_name, getter, setter, [min, max, cost_curve])
	return field

func Enum(id_name: String, pretty_name: String, getter: Callable, setter: Callable, values: Array):
	var field: FieldEnum = field_enum.instantiate()
	field.init(id_name, pretty_name, getter, setter, values)
	return field
