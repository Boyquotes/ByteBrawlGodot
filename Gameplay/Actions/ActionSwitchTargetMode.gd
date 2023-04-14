class_name ActionSwitchTargetMode
extends Action


enum ETargetType {
	None,
	Direction,
	MoveDirection,
	Position,
}

var target_type: ETargetType

const allowed_sequence = [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
const display_name = "SwitchTargetMode"

func _init(target_type: ETargetType):
	self.type = EType.setTarget
	self.target_type = target_type

func _process(delta_time):
	if target_type == ETargetType.None or (_owner_target_locator and not _owner_target_locator.position.is_zero_approx()):
		_done()

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
func get_display_name():
	return self.display_name

static func get_default_values() -> Dictionary:
	return { "target_type": "Direction" }

static func new_from_json(values: Dictionary):
	return ActionSwitchTargetMode.new(ETargetType.get(values["target_type"]))

func set_fields() -> Array[Field]:
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
