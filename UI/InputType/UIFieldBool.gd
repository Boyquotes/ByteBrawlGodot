class_name UIFieldBool
extends UIField

var button: CheckButton

func _ready():
	(get_node("Panel/Label") as Label).text = field.display_name
	button = get_node("FieldBool")
	button.button_pressed = field.getter.call()

func _on_pressed():
	field.setter.call(not field.getter.call())
	button.button_pressed = field.getter.call()
