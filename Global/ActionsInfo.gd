extends Node

var actions = [
	ActionDash,
	ActionThrow,
	ActionGenerateMateria,
	ActionCancelInput,
	ActionChangeStance,
	ActionSwitchTargetDirection,
	ActionSwitchTargetPosition,
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
	],
	"target": [
		ActionSwitchTargetDirection,
		ActionSwitchTargetPosition,
	]
}
