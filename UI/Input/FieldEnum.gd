class_name FieldEnum
extends Field

var popup = Callable(self, "get_popup").call()

func _init():
	popup.connect("id_pressed", on_item_pressed)

func on_item_pressed(item_id: int):
	update_value(popup.get_item_text(item_id))

func update_value(field_value):
	self.text = field_value
	super.update_value(field_value)
