extends Container

var stance_button = load("res://UI/Stance/StanceButton.tscn")
var stance_button_group = load("res://UI/Stance/StanceButtonGroup.tres")

func _init():
	var first_stance: bool = true
	
	for stance in GameInfo.player.gameplay.stances:
		var box: StanceButton = stance_button.instantiate()

		if first_stance:
			box.button_pressed = true
			first_stance = false
		box.button_group = stance_button_group
		box.stance_name = stance.stance_name
		add_child(box)
