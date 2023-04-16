class_name ActionSwitchTargetMode
extends Action


enum ETargetType {
	None,
	Direction,
	MoveDirection,
	Position,
}

var target_type: ETargetType = ETargetType.None
var visible: bool = true

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
		_owner.target_locator.free()
	spawn_target()

func spawn_target():
	var locator: Node2D
	match target_type:
		ETargetType.Direction:
			locator = LocatorDirection.new()
		ETargetType.MoveDirection:
			locator = LocatorMoveDirection.new()
		ETargetType.Position:
			locator = LocatorPosition.new()
	if locator:
		locator.visible = visible
		_owner.add_child(locator)

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
		),
		Field.Bool("visible", "Visible", func(): return visible, func(x): visible = x, CostDiscrete.init_same_values([ true, false ], 1.))
	]
