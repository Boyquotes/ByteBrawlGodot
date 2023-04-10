class_name Materia
extends BaseNode

enum EType
{
	Fire,
	Wind,
	Water,
	Earth,
	
	Lightning,
	Ice,
	Wood,
	Metal,

	Momentum,
	Spacium,
}

var life_time: float
var type: EType

func _init(type: EType, life_time = 5.):
	self.type = type
	self.life_time = life_time

func clone() -> Materia:
	return Materia.new(type, life_time)

func _process(delta_time):
	life_time -= delta_time
	if life_time <= 0:
		queue_free()

func _to_string():
	return \
"""type : %s
lifTime : %.3f
""" % [type, life_time]
