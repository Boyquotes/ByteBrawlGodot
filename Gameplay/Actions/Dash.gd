class_name ActionDash
extends Action

var distance: float

func _init(distance: float = 400.0):
	super._init()
	
	self.duration = 0.2
	self.allowed_stance = [Sequence.EType.Start, Sequence.EType.Release]
	self.type = EType.cast
	self.distance = distance


# LOGIC
func activate():
	(_owner as CharacterBody2D).velocity = (_owner as CharacterBody2D).velocity.normalized() * distance
	var movement_node = _owner.get_node("movement")
	if movement_node:
		(movement_node as Move).block_movement(true)

func done():
	(_owner as CharacterBody2D).velocity = Vector2.ZERO
	var movement_node = _owner.get_node("movement")
	if movement_node:
		(movement_node as Move).block_movement(false)

func cancel():
	done()


# UI HELPER
func get_variables_to_set() -> Array[ActionParameterField]:
	return [
		FloatParameterField.new("velocity", ActionParameterField.EFieldType.Range, 100., 800.)
	]


# DEBUG
func _to_string() -> String:
	return """DASH | duration : %.2f""" % distance
