class_name ActionDash
extends Action

var distance: float

func _init(distance: float):
	super._init()
	
	self.duration = 0.6

	self.type = EActionType.cast
	self.distance = distance

func activate(player: Node):
	if not can_be_cast(player):
		return
	
	(player as CharacterBody2D).velocity = PlayerInput.get_direction() * distance
	(player as CharacterBody2D).move_and_slide()

func cancel(player: Node):
	pass

func get_variables_to_set() -> Array[String]:
	return ["distance"]
