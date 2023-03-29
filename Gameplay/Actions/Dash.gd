class_name ActionDash
extends Action

var velocity: float

func _init(velocity: float):
	super._init()
	
	self.duration = 0.2

	self.type = EActionType.cast
	self.velocity = velocity

func activate(player: Node):
	if not can_be_cast(player):
		return
	
	(player as CharacterBody2D).velocity = PlayerInput.get_direction() * velocity
	(player.get_node("movement") as Move).block_movement = true

func done(player: Node):
	(player as CharacterBody2D).velocity = Vector2.ZERO
	(player.get_node("movement") as Move).block_movement = false
	print("haha")

func cancel(player: Node):
	done(player)

func get_variables_to_set() -> Array[String]:
	return ["distance"]
