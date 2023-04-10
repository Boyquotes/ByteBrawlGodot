extends Node

var actions: Dictionary = {
	"Dash": ActionDash,
	"ChangeStance": ActionChangeStance,
	"SwitchTargetMode": ActionSwitchTargetMode,
	"Throw": ActionThrow,
	"GenerateMateria": ActionGenerateMateria,
}

var field_bool = load("res://UI/Input/FieldBool.tscn")
var field_int = load("res://UI/Input/FieldInt.tscn")
var field_float = load("res://UI/Input/FieldFloat.tscn")
var field_enum = load("res://UI/Input/FieldEnum.tscn")

func Bool(id_name: String, pretty_name: String, getter: Callable, setter: Callable):
	var field: FieldBool = field_bool.instantiate()
	field.init(id_name, pretty_name, getter, setter)
	return field

func Int(id_name: String, pretty_name: String, getter: Callable, setter: Callable, min: int, max: int):
	var field: FieldInt = field_int.instantiate()
	field.init(id_name, pretty_name, getter, setter, [min, max])
	return field

func Float(id_name: String, pretty_name: String, getter: Callable, setter: Callable, min: float, max: float):
	var field: FieldFloat = field_float.instantiate()
	field.init(id_name, pretty_name, getter, setter, [min, max])
	return field

func Enum(id_name: String, pretty_name: String, getter: Callable, setter: Callable, values: Array):
	var field: FieldEnum = field_enum.instantiate()
	field.init(id_name, pretty_name, getter, setter, values)
	return field
