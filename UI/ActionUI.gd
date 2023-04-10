class_name ActionUI
extends Container

var action_parameter = load("res://UI/Parameter.tscn")
var field_bool = load("res://UI/Input/FieldBool.tscn")
var field_float = load("res://UI/Input/FieldFloat.tscn")
var field_enum = load("res://UI/Input/FieldEnum.tscn")
var field_int = load("res://UI/Input/FieldInt.tscn")
var field_default = load("res://UI/Input/Field.tscn")

var TYPE_DICT: Dictionary = {
	"bool": field_bool,
	"float": field_float,
	"enum": field_enum,
	"int": field_int
}

var action_name: String

func init(action_name: String, index: int):
	self.action_name = action_name
	(get_node("Header/Name") as LineEdit).text = action_name
	
	var parameters_container: Container = get_node("ScrollContainerListParameters/ListParameters")
	var values: Dictionary = PlayerInfo.get_selected_actions_values()[index]["values"]
	
	for param_name in values:
		var parameter_info: Dictionary = ActionInfo.actions_info[action_name][param_name]
		var box: Container = action_parameter.instantiate()
		
		box.get_node("Name").text = parameter_info["pretty_name"]
		box.add_child(create_field(param_name, parameter_info, values[param_name]))
		
		parameters_container.add_child(box)

func create_field(param_name: String, parameter_info: Dictionary, value):

	var new_field: Field = TYPE_DICT.get(parameter_info["type"], field_default).instantiate()

	new_field.field_name = param_name
	if parameter_info["type"] == "enum":
		for item in parameter_info["enum_values"]:
			new_field.popup.add_item(item)

	new_field.update_value(value)
	new_field.connect("on_value_changed", input_value_changed)
	
	return new_field

func get_action_values():
	return PlayerInfo.get_selected_actions_values()[get_index()]["values"]

func input_value_changed(field: Field):
	get_action_values()[field.field_name] = field.field_value

func _on_cancel_pressed():
	PlayerInfo.get_selected_actions_values().remove_at(get_index())
	queue_free()
