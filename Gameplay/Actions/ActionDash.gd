class_name ActionDash
extends Action

const distance_min: float = 10.
const distance_max: float = 500.
var distance: float = distance_min:
	set(x): distance = clamp(x, distance_min, distance_max)

static func get_allowed_sequences(): return [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
static func get_action_name(): return "Dash"

func _init():
	self.duration_min = 0.1
	self.duration_max = 2.0
	self.duration = duration_max
	self.block_movement = true
	self.block_action = true
	self.type = EType.cast
	super._init()

# LOGIC
func activate():
	if _owner.target_locator:
		(_owner as CharacterBody2D).velocity = _owner.target_locator.position.normalized() * distance / duration

func done():
	(_owner as CharacterBody2D).velocity = Vector2.ZERO

func cancel():
	done()

# UI HELPER
func get_fields() -> Array[Field]:
	return [
		Field.Float("distance", "Distance", func(): return distance, func(x): distance = x, distance_min, distance_max, CostCurve.new(.1, 10., CostCurve.EMode.Exponential)),
		Field.Float("duration", "Duration", func(): return duration, func(x): duration = x, duration_min, duration_max, CostCurve.new(10., .1, CostCurve.EMode.Exponential))
	]


# DEBUG
func _to_string() -> String:
	return """DASH | duration : %.2f""" % distance
