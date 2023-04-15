class_name ActionSwitchTargetMode
extends Action


enum ETargetType {
	None,
	Direction,
	MoveDirection,
	Position,
}

var target_type: ETargetType = ETargetType.None

static func get_allowed_sequences(): return [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
static func get_action_name(): return "SwitchTargetMode"

func _init():
	self.type = EType.setTarget
	super._init()

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
func init_fields():
	var target_type_keys = ETargetType.keys()
	fields = [
		Field.Enum(
			"target_type",
			"Target Type",
			func(): return target_type_keys[target_type],
			func(x): target_type = ETargetType.get(x),
			CostDiscrete.init_same_values(target_type_keys.slice(1), 1.)
		)
	]
