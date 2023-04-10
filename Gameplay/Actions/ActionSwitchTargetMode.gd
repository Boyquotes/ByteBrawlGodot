class_name ActionSwitchTargetMode
extends Action


enum ETargetType {
	None,
	Direction,
	MoveDirection,
	Position,
}

var target_type: ETargetType

func _init(values: Dictionary):
	self.type = EType.setTarget
	self.target_type = ETargetType.get(values["target_type"])

func activate():
	if _owner_target_locator:
		_owner_target_locator.queue_free()
	spawn_target()

func spawn_target():
	match target_type:
		ETargetType.Direction:
			_owner.add_child(LocatorDirection.new())
		ETargetType.MoveDirection:
			_owner.add_child(LocatorMoveDirection.new())
		ETargetType.Position:
			_owner.add_child(LocatorPosition.new())

# UI HELPER
static func get_default_values() -> Dictionary:
	return {"target_type": "Direction"}

func get_variables_to_set() -> Array[Field]:
	var target_type_keys = ETargetType.keys()
	return [
		ActionsInfo.Enum(
			"target_type",
			"Target Type",
			func(): return target_type_keys[target_type],
			func(x): target_type = ETargetType.get(x),
			target_type_keys.slice(1)
		)
	]

func done():
	pass
