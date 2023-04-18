extends Node

var actions = [
	ActionDash,
	ActionThrow,
	ActionGenerateMateria,
	ActionCancelInput,
	ActionChangeStance,
	ActionSwitchTargetDirection,
	ActionSwitchTargetPosition,
	ActionSpell,
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
		ActionSpell,
	],
	"target": [
		ActionSwitchTargetDirection,
		ActionSwitchTargetPosition,
	]
}
