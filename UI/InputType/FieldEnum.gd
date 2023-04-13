class_name FieldEnum
extends Field

var popup: PopupMenu

var button: MenuButton

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, items_string: Array = []):
	button = get_node("Button")
	
	popup = button.get_popup()
	
	popup.connect("id_pressed", on_item_pressed)
	for item_string in items_string:
		popup.add_item(item_string)
	
	(get_node("Panel/Label") as Label).text = pretty_name
	
	super.init(field_name, pretty_name, getter, setter)

func _ready():
	button.text = getter.call()

func on_item_pressed(item_id: int):
	update_value(popup.get_item_text(item_id))

func update_value(field_value):
	super.update_value(field_value)
	button.text = getter.call()
