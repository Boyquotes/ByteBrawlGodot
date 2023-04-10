class_name FieldEnum
extends Field

var popup: PopupMenu
var items_string: Array

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, items_string: Array = []):
	self.items_string = items_string
	
	popup = (self as Control as MenuButton).get_popup()
	
	popup.connect("id_pressed", on_item_pressed)
	for item_string in items_string:
		popup.add_item(item_string)
	
	super.init(field_name, pretty_name, getter, setter)

func _ready():
	self.text = getter.call()

func on_item_pressed(item_id: int):
	update_value(popup.get_item_text(item_id))

func update_value(field_value):
	super.update_value(field_value)
	self.text = getter.call()
