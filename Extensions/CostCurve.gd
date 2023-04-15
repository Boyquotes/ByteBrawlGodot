class_name CostCurve
extends Curve

enum EMode
{
	Exponential,
	Linear,
	Logarithm,
	Manual
}

func normalize_eval(x: float, min_value = null, max_value = null) -> float:
	if min_value == null:
		min_value = self.min_value
	if max_value == null:
		max_value = self.max_value
	return (sample(x) - min_value) / (max_value - min_value)

func _init(left_value: float, right_value: float, curve_mode: EMode, curve_points: Array[CurvePoint] = []):
	self.min_value = min(left_value, right_value)
	self.max_value = max(left_value, right_value)
	
	var inv: bool = right_value - left_value < 0
	
	if curve_mode == EMode.Exponential:
		add_point(Vector2(0., left_value), 0., (right_value - left_value) * 2.5 if inv else 1.)
		add_point(Vector2(1., right_value), -1 if inv else (right_value - left_value) * 2.5, 0.)
	
	elif curve_mode == EMode.Linear:
		add_point(Vector2(0., left_value), 0., 0., Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
		add_point(Vector2(1., right_value), 0., 0., Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
	
	elif curve_mode == EMode.Logarithm:
		add_point(Vector2(0., left_value), 0., -1.0 if inv else (right_value - left_value) * 2.5)
		add_point(Vector2(1., right_value), (right_value - left_value) * 2.5 if inv else 1., 0.)
	
	for curve_point in curve_points:
		add_point(curve_point.pos, curve_point.left_tangent, curve_point.right_tangent)
	
