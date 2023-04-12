class_name FieldFloat
extends Field

const slider_number_of_step: int = 100

var line_edit: LineEdit
var slider: Slider

var gradient: Gradient
var gradient_precision: int = 5
var max_color: Color = Color.RED
var min_color: Color = Color.WHITE

var cost_curve: CostCurve

func _on_text_changed(new_text: String):
	if new_text == "":
		line_edit.text = ""
		line_edit.placeholder_text = str(getter.call())

func _ready():
	line_edit.text = str(getter.call())
	slider.value = getter.call()

func init_gradient():
	self.gradient = Gradient.new()
	
	for i in gradient_precision:
		var offset: float = 1 - i / (gradient_precision - 1.)
		gradient.add_point(offset, Color.BLACK)
	
	gradient.remove_point(0)
	gradient.remove_point(0)
	
	update_gradient()

func update_gradient():
	for i in gradient_precision:
		var factor: float = cost_curve.normalize_eval(i / (gradient_precision - 1.))
		gradient.set_color(i, factor*max_color + (1 - factor)*min_color)

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	get_node("Panel/Label").text = pretty_name
	self.line_edit = get_node("HBoxContainer/LineEdit")
	self.slider = get_node("HBoxContainer/HSlider")
	
	self.slider.min_value = _args[0]
	self.slider.max_value = _args[1]
	self.slider.step = (_args[1] - _args[0]) / slider_number_of_step
	
	self.cost_curve = _args[2]
	
	init_gradient()
	var style_box = StyleBoxTexture.new()
	style_box.texture = GradientTexture1D.new()
	style_box.texture.gradient = self.gradient
	style_box.texture_margin_top = 12
	style_box.texture_margin_bottom = 12
	self.slider.add_theme_stylebox_override("slider", style_box)
	
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
