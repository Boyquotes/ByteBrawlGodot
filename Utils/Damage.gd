class_name Damage

enum EElementType {
	None,
	Fire,
	Water,
	Air,
	Earth,
}

enum EDamageType {
	None,
	Piercing,
	Cutting,
	Blunt,
	Explosive,
}

var element: EElementType = EElementType.None
var type: EDamageType = EDamageType.None
var amount: float

func _init(amout: float, type: EDamageType, element: EElementType):
	self.amount = amout
	self.type = type
	self.element = element
