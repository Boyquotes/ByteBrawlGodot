extends Node
class_name UIInfo

var selected_sequence_name: String = "started_sequence"
var selected_input_index: int = 0
var selected_stance_name: String = "normal"

var action_list: ActionList
var action_selector: ActionSelector
var input_details_manager: InputDetailsManager

var selected_stance: Stance:
	get: return GameInfo.player.gameplay.get_stance(selected_stance_name)

var selected_input: ActionInput:
	get: return selected_stance.inputs[selected_input_index]

var selected_sequence: Sequence:
	get: return selected_input.get(selected_sequence_name)
