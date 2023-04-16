extends Node

var actions = [
	ActionDash,
	ActionThrow,
	ActionGenerateMateria,
	ActionCancelInput,
	ActionChangeStance,
	ActionSwitchTargetDirection,
	ActionSwitchTargetPosition,
	ActionSpellMateriaProjectile,
]

var sorted_action = {
	"utils": [
		ActionCancelInput,
		ActionChangeStance,
	],
	"skills": [
		ActionDash,
		ActionThrow,
	],
	"magic": [
		ActionGenerateMateria,
		ActionSpellMateriaProjectile,
	],
	"target": [
		ActionSwitchTargetDirection,
		ActionSwitchTargetPosition,
	]
}
