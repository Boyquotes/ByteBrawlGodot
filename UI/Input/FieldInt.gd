class_name FieldInt
extends Field

func _ready():
	self.value = getter.call()

func _on_pressed():
	update_value(self.value)
	
	var new_value: int = getter.call()
	if self.value != new_value:
		self.value = new_value
