class_name NoObstaclesAtLocation
extends Requirement

var relativeLocation: Vector2
var collisionShape: CollisionShape2D

func _init(relativeLocation: Vector2):
	super._init()
	
	self.relativeLocation = relativeLocation
	self.collisionShape = collisionShape
	
func is_satisfied(player: Node) -> bool:
	return true
