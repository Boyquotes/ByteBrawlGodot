class_name FieldInt
extends FieldSlider

var spinbox: SpinBox
var slider: Slider

func _ready():
	spinbox.value = getter.call()
	slider.value = getter.call()

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	get_node("Panel/Label").text = pretty_name
	spinbox = get_node("HBoxContainer/SpinBox")
	slider = get_node("HBoxContainer/HSlider")
	
	slider.min_value = _args[0]
	spinbox.min_value = _args[0]
	slider.max_value = _args[1]
	spinbox.max_value = _args[1]
	
	super.init(field_name, pretty_name, getter, setter, [_args[2]])

func update_value(field_value):
	super.update_value(field_value)
	
	var new_value: int = getter.call()
	
	if new_value != spinbox.value:
		spinbox.value = new_value
	slider.value = new_value

func _on_value_changed(value):
	update_value(value)
