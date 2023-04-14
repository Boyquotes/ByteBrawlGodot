class_name ActionSwitchTargetMode
extends Action


enum ETargetType {
	None,
	Direction,
	MoveDirection,
	Position,
}

var target_type: ETargetType = ETargetType.None

const allowed_sequence = [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
const action_name = "SwitchTargetMode"

func _init():
	super._init()
	self.type = EType.setTarget

func _process(delta_time):
	if target_type == ETargetType.None or (_owner.target_locator and not _owner.target_locator.position.is_zero_approx()):
		_done()

func activate():
	if _owner.target_locator:
		_owner.target_locator.queue_free()
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
func set_fields() -> Array[Field]:
	var target_type_keys = ETargetType.keys()
	self.fields = [
		ActionsInfo.Enum(
			"target_type",
			"Target Type",
			func(): return target_type_keys[target_type],
			func(x): target_type = ETargetType.get(x),
			CostDiscrete.init_same_values(target_type_keys.slice(1), 1.)
		)
	]
