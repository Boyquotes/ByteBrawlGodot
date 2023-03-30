class_name ActionChangeStance
extends Action

var stance: Stance

func _init(stance: Stance):
	super._init()
	self.stance = stance
	self.duration = 0.1
	self.type = EActionType.changeStance


func done():
	var gameplay_node = _owner.get_node("gameplay")
	if gameplay_node:
		(gameplay_node as Gameplay).change_stance(stance)
	pass
