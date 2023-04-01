class_name ActionSwitchTargetMode
extends Action


enum ETargetType {
	None,
	Direction,
	Position,
}

var target_type = ETargetType.None

func _init(type: ETargetType):
	self.target_type = type

func activate():
	if _owner_target_locator:
		_owner_target_locator.queue_free()
	spawn_target()

func spawn_target():
	match target_type:
		ETargetType.Direction:
			_owner.add_child(LocatorDirection.new())
		ETargetType.Position:
			_owner.add_child(LocatorPosition.new())



func done():
	pass
