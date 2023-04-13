class_name FieldSlider
extends Field

var gradient: Gradient
var gradient_precision: int = 5
var max_color: Color = Color.RED
var min_color: Color = Color.WHITE

var cost_curve: CostCurve

func _init():
	pass

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
	self.cost_curve = _args[0]
	
	init_gradient()
	var style_box = StyleBoxTexture.new()
	style_box.texture = GradientTexture1D.new()
	style_box.texture.gradient = self.gradient
	style_box.texture_margin_top = 12
	style_box.texture_margin_bottom = 12
	self.slider.add_theme_stylebox_override("slider", style_box)
	
	super.init(field_name, pretty_name, getter, setter)
