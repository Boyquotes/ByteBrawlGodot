class_name ActionChangeStance
extends Action

var stance: Stance

func _init(stance: Stance):
	super._init()
	self.stance = stance
	self.duration = 0.1
	self.end_sequence = true
	self.allowed_sequence = [Sequence.EType.Release]
	self.type = EType.changeStance

func done():
	var gameplay_node = _owner.get_node("gameplay")
	if gameplay_node:
		(gameplay_node as Gameplay).change_stance(stance)
	pass

# UI HELPER
static func get_default_values() -> Dictionary:
	return {"stance": "normal"}
	
static func new_from_editor(values: Dictionary):
	return ActionChangeStance.new(PlayerInfo.stances[values["stance"]])

func get_variables_to_set() -> Array[Field]:
	return [
		ActionsInfo.Enum(
			"stance",
			"Stance",
			func(): return stance.stance_name,
			func(x): stance = PlayerInfo.stances[x],
			PlayerInfo.stances.values().map(func(x): return x.stance_name)
		)
	]
