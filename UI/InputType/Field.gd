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

var action_ui: ActionUI

func _get_cost(): return 0
var cost: float:
	get: return _get_cost()

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	self.field_name = field_name
	self.getter = getter
	self.setter = setter

func update_value(field_value):
	setter.call(field_value)
