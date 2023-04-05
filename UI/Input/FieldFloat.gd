class_name FieldFloat
extends Field

func _on_focus_exited():
	if self.text == "":
		self.text = str(field_value)

func _on_text_changed(new_text: String):
	if new_text.is_valid_float():
		super.update_value(new_text)
	elif new_text == "":
		self.text = ""
		self.placeholder_text = str(field_value)
	else:
		self.text = str(field_value)

func update_value(field_value):
	self.text = str(field_value)
	super.update_value(field_value)
