class_name FieldBool
extends Field

func _on_pressed():
	self.field_value = self.button_pressed
	update_value(field_value)

func update_value(updated_value):
	self.button_pressed = updated_value
	super.update_value(updated_value)
