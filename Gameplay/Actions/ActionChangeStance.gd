class_name ActionChangeStance
extends Action

var stance: Stance = GameInfo.player.gameplay.get_stance("normal")

static func get_allowed_sequences(): return [Sequence.EType.released_sequence]
static func get_action_name(): return "ChangeStance"


func _init():
	self.duration = 0.1
	self.end_sequence = true
	self.type = EType.changeStance
	super._init()

func done():
	if _owner.gameplay:
		_owner.gameplay.change_stance(stance)

# UI HELPER
func init_fields():
	fields = [
		Field.Enum(
			"stance",
			"Stance",
			func(): return stance.stance_name,
			func(x): stance = GameInfo.player.gameplay.get_stance(x),
			CostDiscrete.init_same_values(GameInfo.player.gameplay.stances.map(func(x): return x.stance_name), 1.5)
		)
	]
