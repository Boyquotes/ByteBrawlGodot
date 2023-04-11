extends Button
class_name StanceButton

var stance_name: String

func _ready():
	text = stance_name

func _pressed():
	PlayerInfo.selected_stance = stance_name
	PlayerInfo.action_list.reset()
	PlayerInfo.action_selector.reset()
