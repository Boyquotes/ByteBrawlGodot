class_name FieldBool
extends FieldDiscrete

var field_bool = load("res://UI/InputType/UIFieldBool.tscn")

func _init(id_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	super._init(id_name, pretty_name, getter, setter, _args)

func instantiate_ui_field() -> UIField:
	var new_field: UIFieldBool = field_bool.instantiate()
	new_field.init(self)
	return new_field
