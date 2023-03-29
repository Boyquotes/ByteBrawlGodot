class_name Stance
extends Node2D

var is_active: bool = false

var inputs: Array[ActionInput] = []

func _input(event):
	if event.is_pressed():
		print("INPUT")

func _init():
	print("INIT")

func _ready():
	print("READY")

func _enter_tree():
	print("ENTER TREE")
	
func _exit_tree():
	print("EXIT TREE")

func _process(delta):
	pass

func _to_string() -> String:
	return \
"""inputs : %s""" % str(inputs)
