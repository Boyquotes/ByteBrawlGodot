class_name ActionDash
extends Action

const distance_min: float = 10.
const distance_max: float = 500.
var distance: float = distance_min:
	set(x): distance = clamp(x, distance_min, distance_max)


func _init(values: Dictionary):
	super._init()
	self.duration_min = 0.1
	self.duration_max = 2.0
	self.allowed_stance = [Sequence.EType.Start, Sequence.EType.Release]
	self.block_movement = true
	self.block_action = true
	self.type = EType.cast
	self.duration = values["duration"]
	self.distance = values["distance"]


# LOGIC
func activate():
	(_owner as CharacterBody2D).velocity = (_owner as CharacterBody2D).velocity.normalized() * distance / duration

func done():
	(_owner as CharacterBody2D).velocity = Vector2.ZERO

func cancel():
	done()


# UI HELPER
static func get_default_values() -> Dictionary:
	return {"distance": 50, "duration": 0.2}

func get_variables_to_set() -> Array[Field]:
	return [
		ActionsInfo.Float("distance", "Distance", func(): return distance, func(x): distance = x, distance_min, distance_max),
		ActionsInfo.Float("duration", "Duration", func(): return duration, func(x): duration = x, duration_min, duration_max)
	]


# DEBUG
func _to_string() -> String:
	return """DASH | duration : %.2f""" % distance
