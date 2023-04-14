class_name ActionDash
extends Action

const distance_min: float = 10.
const distance_max: float = 500.
var distance: float = distance_min:
	set(x): distance = clamp(x, distance_min, distance_max)

const allowed_sequence: Array[Sequence.EType] = [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
const display_name = "Dash"

func _init(distance: float, duration: float):
	super._init()
	self.duration_min = 0.1
	self.duration_max = 2.0
	self.block_movement = true
	self.block_action = true
	self.type = EType.cast
	self.duration = duration
	self.distance = distance

# LOGIC
func activate():
	if _owner_target_locator:
		(_owner as CharacterBody2D).velocity = _owner_target_locator.position.normalized() * distance / duration

func done():
	(_owner as CharacterBody2D).velocity = Vector2.ZERO

func cancel():
	done()


# UI HELPER
static func get_default_values() -> Dictionary:
	return { "distance": 50, "duration": 0.2 }

static func new_from_editor(values: Dictionary):
	return ActionDash.new(values["distance"], values["duration"])

func get_variables_to_set() -> Array[Field]:
	return [
		ActionsInfo.Float("distance", "Distance", func(): return distance, func(x): distance = x, distance_min, distance_max, CostCurve.new(.1, 10., CostCurve.EMode.Exponential)),
		ActionsInfo.Float("duration", "Duration", func(): return duration, func(x): duration = x, duration_min, duration_max, CostCurve.new(10., .1, CostCurve.EMode.Exponential))
	]


# DEBUG
func _to_string() -> String:
	return """DASH | duration : %.2f""" % distance
