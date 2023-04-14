class_name ActionChangeStance
extends Action

var stance: Stance = GameInfo.player.gameplay.get_stance("normal")
const allowed_sequence = [Sequence.EType.released_sequence]
const action_name = "ChangeStance"

func _init():
	super._init()
	self.duration = 0.1
	self.end_sequence = true
	self.type = EType.changeStance

func done():
	var gameplay_node = _owner.get_node("gameplay")
	if gameplay_node:
		(gameplay_node as Gameplay).change_stance(stance)

# UI HELPER
func set_fields():
	self.fields = [
		ActionsInfo.Enum(
			"stance",
			"Stance",
			func(): return stance.stance_name,
			func(x): stance = GameInfo.player.gameplay.get_stance(x),
			CostDiscrete.init_same_values(GameInfo.player.gameplay.stances.map(func(x): return x.stance_name), 1.5)
		)
	]
