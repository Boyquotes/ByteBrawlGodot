class_name ActionSwitchTargetPosition
extends Action


enum ETargetType {
	Position
}

var target_type: ETargetType = ETargetType.Position
var visible: bool = true

const distance_min: float = 10.
const distance_max: float = 500.
var distance: float = 100.

static func get_allowed_sequences(): return [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
static func get_action_name(): return "SwitchTargetPosition"

func _init():
	self.type = EType.setTarget
	self.duration = .2
	super._init()

func activate():
	if _owner.target_locator:
		_owner.target_locator.free()
	spawn_target()

func spawn_target():
	var locator: Node2D
	match target_type:
		ETargetType.Position:
			locator = LocatorPosition.new(distance)
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
			CostDiscrete.init_same_values(target_type_keys, 1.)
		),
		Field.Bool("visible", "Visible", func(): return visible, func(x): visible = x, CostDiscrete.init_same_values([ true, false ], 1.)),
		Field.Float("distance", "Distance", func(): return distance, func(x): distance = x, distance_min, distance_max, CostCurve.new(.1, 20., CostCurve.EMode.Exponential)),
	]
