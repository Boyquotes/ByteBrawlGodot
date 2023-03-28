class_name ActionDash
extends Action

var distance: float

func _init(distance: float):
	super._init()
	
	type = EActionType.cast
	self.distance = distance

func activate(player: Node):
	if not canBeCast(player):
		return
	
	player.move_and_slide(PlayerInput.get_direction() * distance)

func cancel(player: Node):
	pass

func get_variables_to_set() -> Array[String]:
	return ["distance"]
