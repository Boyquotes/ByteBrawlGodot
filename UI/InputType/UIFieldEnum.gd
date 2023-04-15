class_name UIFieldEnum
extends UIField

var popup: PopupMenu

var button: MenuButton

func _ready():
	button = get_node("Button")
	
	popup = button.get_popup()
	
	popup.connect("id_pressed", on_item_pressed)
	for item_string in field.cost_discrete.values:
		popup.add_item(item_string)
	
	(get_node("Panel/Label") as Label).text = field.field_name

	button.text = field.getter.call()

func on_item_pressed(item_id: int):
	field.setter.call(popup.get_item_text(item_id))
	button.text = field.getter.call()
