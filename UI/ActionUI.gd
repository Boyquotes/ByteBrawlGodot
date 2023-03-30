class_name ActionUI
extends Container

var action_parameter = load("res://UI/Parameter.tscn")
var parameters: Array

func init(action_name: String, parameters: Array, index: int):
	(get_node("Header/Name") as LineEdit).text = action_name
	self.parameters = PlayerInfo.get_selected_action_list()[index]["parameters"]

func _ready():
	var i = 0
	for parameter in parameters:
		var box: FieldFloat = action_parameter.instantiate()
		
		box.value = parameter["value"]
		box.text = str(box.value)
		box.connect("on_value_changed", input_value_changed)
		get_node("ScrollContainerListParameters/ListParameters").add_child(box)
		
		i += 1

func input_value_changed(input: FieldFloat):
	parameters[input.get_index()]["value"] = input.value

func _on_cancel_pressed():
	PlayerInfo.get_selected_action_list().remove_at(get_index())
	queue_free()
