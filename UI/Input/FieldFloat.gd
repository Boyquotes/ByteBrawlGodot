class_name FieldFloat
extends Field

const slider_number_of_step: int = 100

var line_edit: LineEdit
var slider: Slider

func _on_text_changed(new_text: String):
	if new_text == "":
		line_edit.text = ""
		line_edit.placeholder_text = str(getter.call())

func _ready():
	line_edit.text = str(getter.call())
	slider.value = getter.call()

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	get_node("Panel/Label").text = pretty_name
	line_edit = get_node("HBoxContainer/LineEdit")
	slider = get_node("HBoxContainer/HSlider")
	
	slider.min_value = _args[0]
	slider.max_value = _args[1]
	slider.step = (_args[1] - _args[0]) / slider_number_of_step
	
	super.init(field_name, pretty_name, getter, setter)

func update_value(field_value):
	super.update_value(field_value)
	
	var new_text: String = str(getter.call())
	if line_edit.text != new_text:
		line_edit.text = new_text
	
	slider.value = getter.call()

func _on_line_edit_focus_exited():
	if line_edit.text == "":
		line_edit.text = str(getter.call())
		slider.value = getter.call()
	elif line_edit.text.is_valid_float():
		update_value(float(line_edit.text))
	else:
		update_value(getter.call())


func _on_line_edit_text_submitted(new_text):
	_on_line_edit_focus_exited()

func _on_h_slider_value_changed(value):
	update_value(value)
