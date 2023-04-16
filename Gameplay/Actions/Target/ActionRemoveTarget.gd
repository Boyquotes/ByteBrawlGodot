extends Action
class_name ActionRemoveTarget

static func get_allowed_sequences(): return []
static func get_action_name(): return "RemoveTarget"

func _init():
	self.type = EType.setTarget
	super._init()

func _process(delta_time):
	_done()

func activate():
	if _owner.target_locator:
		_owner.target_locator.free()
