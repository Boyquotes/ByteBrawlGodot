class_name UIFieldInt
extends UIFieldSlider

var spinbox: SpinBox

func _ready():
	get_node("Panel/Label").text = field.field_name
	spinbox = get_node("HBoxContainer/SpinBox")
	slider = get_node("HBoxContainer/HSlider")
	
	spinbox.min_value = field.min_value
	spinbox.max_value = field.max_value
	
	spinbox.value = field.getter.call()
	super._ready()

func _on_value_changed(value):
	field.setter.call(value)
	
	var new_value: int = field.getter.call()
	
	if new_value != spinbox.value:
		spinbox.value = new_value
	slider.value = new_value
