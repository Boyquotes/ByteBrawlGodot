extends Control

var InputHUD = load("res://HUD/Inputs/ActionInputHUD.tscn")

@onready var container = self.get_node("container")

var inputs: Array[ActionInput]:
	get: return GameInfo.player.gameplay.current_stance.inputs

func _ready():
	init_inputs()
	GameInfo.player.gameplay.stance_changed.connect(replace_inputs)

func init_inputs():
	for input in inputs:
		var input_hud = InputHUD.instantiate()
		container.add_child(input_hud)
		input_hud.init(input)

func remove_inputs():
	for input_hud in container.get_children():
		input_hud.queue_free()

func replace_inputs():
	remove_inputs()
	init_inputs()
