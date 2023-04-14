class_name ActionChangeStance
extends Action

var stance: Stance
const allowed_sequence = [Sequence.EType.released_sequence]
const display_name = "ChangeStance"

func _init(stance: Stance):
	super._init()
	self.stance = stance
	self.duration = 0.1
	self.end_sequence = true
	self.type = EType.changeStance

func done():
	var gameplay_node = _owner.get_node("gameplay")
	if gameplay_node:
		(gameplay_node as Gameplay).change_stance(stance)
	pass

# UI HELPER
static func get_default_values() -> Dictionary:
	return {"stance": "normal"}

static func new_from_json(values: Dictionary):
	return ActionChangeStance.new(PlayerInfo.stances[values["stance"]])

func set_fields() -> Array[Field]:
	return [
		ActionsInfo.Enum(
			"stance",
			"Stance",
			func(): return stance.stance_name,
			func(x): stance = PlayerInfo.stances[x],
			CostDiscrete.init_same_values(PlayerInfo.stances.values().map(func(x): return x.stance_name), 1.5)
		)
	]
