class_name CurvePoint

var pos: Vector2
var left_tangent: float
var right_tangent: float

func _init(x: float, y: float, left_tangent: float = 0., right_tangent: float = 0.):
	self.pos = Vector2(x, y)
	self.left_tangent = left_tangent
	self.right_tangent = right_tangent
