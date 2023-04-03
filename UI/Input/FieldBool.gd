class_name FieldBool
extends Field

func _on_pressed():
	field_value = self.button_pressed
	update_value(field_value)

func update_value(field_value):
	self.button_pressed = field_value
	super.update_value(field_value)
