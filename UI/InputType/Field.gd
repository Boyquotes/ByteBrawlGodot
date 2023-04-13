class_name Field
extends Control

enum EFieldType
{
	Bool,
	Float,
	Int,
	Materia,
	Stance,
	Enum
}

var field_name: String
var setter: Callable
var getter: Callable

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	self.field_name = field_name
	self.getter = getter
	self.setter = setter
	add_user_signal("on_value_changed",  [{"name": "field", "type": Field}])

func update_value(field_value):
	setter.call(field_value)
	emit_signal("on_value_changed", self)
