class_name UIFieldSlider
extends UIField

var gradient: Gradient
var gradient_precision: int = 5
var max_color: Color = Color.RED
var min_color: Color = Color.WHITE

var _is_ready = false

var slider: Slider
var max_field_cost_in_action: float:
	get: return get_max_field_cost_in_action()

@onready var action_ui: ActionUI = find_parent("ActionUI*")

func get_max_field_cost_in_action():
	return action_ui.action.fields.map(func(x): return x.max_cost).max()

func init_gradient():
	self.gradient = Gradient.new()
	
	for i in gradient_precision:
		var offset: float = 1 - i / (gradient_precision - 1.)
		gradient.add_point(offset, Color.BLACK)
	
	gradient.remove_point(0)
	gradient.remove_point(0)
	
	update_gradient()

func update_gradient():
	var new_max_color = Color.RED
	
	for i in gradient_precision:
		var factor: float = field.cost_curve.normalize_eval(i / (gradient_precision - 1.), null, max_field_cost_in_action)
		gradient.set_color(i, factor*new_max_color + (1 - factor)*min_color)

func _ready():
	init_gradient()
	var style_box = StyleBoxTexture.new()
	style_box.texture = GradientTexture1D.new()
	style_box.texture.gradient = self.gradient
	style_box.texture_margin_top = 12
	style_box.texture_margin_bottom = 12
	self.slider.add_theme_stylebox_override("slider", style_box)
	slider.min_value = field.min_value
	slider.max_value = field.max_value
	slider.value = field.getter.call()
	_is_ready = true

