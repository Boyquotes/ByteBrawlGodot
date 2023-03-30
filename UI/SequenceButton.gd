class_name SequenceButton
extends Button

var sequence_name: String

func _init():
	sequence_name = editor_description

func _pressed():
	print("button pressed")
	PlayerInfo.selected_sequence = sequence_name
	PlayerInfo.action_list.reset()
