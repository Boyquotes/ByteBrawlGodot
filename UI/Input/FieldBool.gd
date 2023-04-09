class_name FieldBool
extends Field

func _ready():
	self.button_pressed = getter.call()

func _on_pressed():
	update_value(not getter.call())

func update_value(updated_value):
	super.update_value(updated_value)
	self.button_pressed = getter.call()
