extends Action
class_name ActionCancelInput


static func get_allowed_sequences(): return [Sequence.EType.started_sequence]
static func get_action_name(): return "CancelInput"

func _init():
	self.type = EType.cancelInput

func _activate():
	for input in _owner.gameplay.current_stance.get_children() as Array[ActionInput]:
		if not input.is_ancestor_of(self):
			input.cancel()
