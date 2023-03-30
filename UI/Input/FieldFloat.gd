class_name FieldFloat
extends LineEdit

var value: float

func _init():
	add_user_signal("on_value_changed",  [{"name": "input", "type": FieldFloat}])

func _on_focus_exited():
	if text == "":
		text = str(value)

func _on_text_changed(new_text: String):
	if new_text.is_valid_float():
		value = float(new_text)
		emit_signal("on_value_changed", self)
	elif new_text == "":
		text = ""
		placeholder_text = str(value)
	else:
		text = str(value)
