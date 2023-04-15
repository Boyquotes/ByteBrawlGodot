class_name UIFieldFloat
extends UIFieldSlider

const slider_number_of_step: int = 120

var line_edit: LineEdit

func _on_text_changed(new_text: String):
	if new_text == "":
		line_edit.text = ""
		line_edit.placeholder_text = str(field.getter.call())

func _ready():
	get_node("Panel/Label").text = field.display_name
	self.line_edit = get_node("HBoxContainer/LineEdit")
	self.slider = get_node("HBoxContainer/HSlider")
	
	self.slider.step = (field.max_value - field.min_value) / slider_number_of_step
	
	line_edit.text = str(field.getter.call())
	
	super._ready()

func update_value(field_value):
	field.setter.call(field_value)
	
	var new_text: String = str(field.getter.call())
	if line_edit.text != new_text:
		line_edit.text = new_text
	
	var new_value: float = field.getter.call()
	if slider.value != new_value:
		slider.value = new_value

func _on_line_edit_focus_exited():
	if line_edit.text == "":
		line_edit.text = str(field.getter.call())
		slider.value = field.getter.call()
	elif line_edit.text.is_valid_float():
		update_value(float(line_edit.text))
	else:
		update_value(field.getter.call())


func _on_line_edit_text_submitted(new_text):
	if self._is_ready:
		_on_line_edit_focus_exited()

func _on_h_slider_value_changed(value):
	if self._is_ready:
		update_value(value)
