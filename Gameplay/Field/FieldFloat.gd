class_name FieldFloat
extends FieldRange

var field_float = load("res://UI/InputType/UIFieldFloat.tscn")

func _init(id_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	super._init(id_name, pretty_name, getter, setter, _args)

func instantiate_ui_field() -> UIField:
	var new_field: UIFieldFloat = field_float.instantiate()
	new_field.init(self)
	return new_field
