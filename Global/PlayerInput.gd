class_name PlayerInput

const PLAYER_INPUT = [
	"input_1",
	"input_2",
	"input_3",
	"input_4",
]

static func get_direction():
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")



static func get_input_type(event: InputEvent) -> InputType:
	for input in PLAYER_INPUT.size():
		if event.is_action_pressed(PLAYER_INPUT[input]): return InputType.new(EInputType.PRESS, input)
		if event.is_action_released(PLAYER_INPUT[input]): return InputType.new(EInputType.RELEASE, input)
	return null

enum EInputType { PRESS, RELEASE }

class InputType:
	var type: EInputType
	var key: int

	func _init(type: EInputType, key: int):
		self.type = type
		self.key = key