class_name ActionUI
extends Container

var action_parameter = load("res://UI/Parameter.tscn")
var field_bool = load("res://UI/Input/FieldBool.tscn")
var field_float = load("res://UI/Input/FieldFloat.tscn")
var field_enum = load("res://UI/Input/FieldEnum.tscn")
var field_int = load("res://UI/Input/FieldInt.tscn")
var field_default = load("res://UI/Input/Field.tscn")

var parameters: Array

func init(action_name: String, parameters: Array, index: int):
	(get_node("Header/Name") as LineEdit).text = action_name
	self.parameters = PlayerInfo.get_selected_action_list()[index]["parameters"]

func create_field(parameter: Dictionary):
	var dict: Dictionary = {
		"bool": field_bool,
		"float": field_float,
		"enum": field_enum,
		"int": field_int
	}
	var new_field: Field = dict.get(parameter["type"], field_default).instantiate()
	
	if parameter["type"] == "enum":
		for item in parameter["enum_values"]:
			new_field.popup.add_item(item)
	new_field.update_value(parameter["value"])
	
	return new_field

func _ready():
	var i = 0
	for parameter in parameters:
		var box: Container = action_parameter.instantiate()
		var box_name: LineEdit = box.get_node("Name")
		
		box_name.text = parameter["name"]
		var new_field = create_field(parameter)
		box.add_child(new_field)
		new_field.connect("on_value_changed", input_value_changed)
		print(new_field.is_connected("on_value_changed", input_value_changed))
		
		get_node("ScrollContainerListParameters/ListParameters").add_child(box)
		
		i += 1

func get_parameter(field: Field):
	return parameters[field.get_parent().get_index()]

func input_value_changed(field: Field):
	print(field.field_value, "HGIYG")
	get_parameter(field)["value"] = field.field_value

func _on_cancel_pressed():
	PlayerInfo.get_selected_action_list().remove_at(get_index())
	queue_free()
