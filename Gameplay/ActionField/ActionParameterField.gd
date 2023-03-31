class_name ActionParameterField

enum EFieldType
{
	# Bool
	Bool,
	# Float
	Range,
	Float,
	# Materia
	Materia,
	# Stance
	Stance,
	# Enum
	Choice,
}

var key: String
var type: EFieldType

func _init(key: String, type: EFieldType):
	self.key = key
	self.type = type

