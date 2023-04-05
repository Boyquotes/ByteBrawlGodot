class_name Field
extends Control

var field_value
var field_name

func _init():
	add_user_signal("on_value_changed",  [{"name": "field", "type": Field}])

func update_value(field_value):
	self.field_value = field_value
	emit_signal("on_value_changed", self)
