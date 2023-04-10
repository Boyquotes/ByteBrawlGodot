class_name FieldEnum
extends Field

var popup: PopupMenu

func _init():
	self.popup = (self as Control as MenuButton).get_popup()
	self.popup.connect("id_pressed", on_item_pressed)
	super._init()

func on_item_pressed(item_id: int):
	update_value(popup.get_item_text(item_id))

func update_value(field_value):
	self.text = field_value
	super.update_value(field_value)
