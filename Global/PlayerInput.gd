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
	for input_name in PLAYER_INPUT:
		if event.is_action_pressed(input_name):
			return InputType.new(EInputType.PRESS, input_name)
		if event.is_action_released(input_name):
			return InputType.new(EInputType.RELEASE, input_name)
	return null

enum EInputType { PRESS, RELEASE }

class InputType:
	var type: EInputType
	var key: String

	func _init(type: EInputType, key: String):
		self.type = type
		self.key = key
