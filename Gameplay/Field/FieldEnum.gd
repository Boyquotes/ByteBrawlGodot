class_name FieldEnum
extends FieldDiscrete

var field_enum = load("res://UI/InputType/UIFieldEnum.tscn")

func _init(id_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	super._init(id_name, pretty_name, getter, setter, _args)

func instantiate_ui_field() -> UIField:
	var new_field: UIFieldEnum = field_enum.instantiate()
	new_field.init(self)
	return new_field
