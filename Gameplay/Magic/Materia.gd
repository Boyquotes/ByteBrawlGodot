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

var generation_time_customer: float
var life_time: float
var type: EType

func _init(type: EType, generation_time_customer = 1., life_time = 5.):
	self.type = type
	self.generation_time_customer = generation_time_customer
	self.life_time = life_time

func clone() -> Materia:
	return Materia.new(type, generation_time_customer, life_time)

func _process(delta_time):
	life_time -= delta_time
	if life_time <= 0:
		queue_free()

func _to_string():
	return \
"""type : %s
generationTimeCustomer : %.3f
lifTime : %.3f
""" % [type, generation_time_customer, life_time]
