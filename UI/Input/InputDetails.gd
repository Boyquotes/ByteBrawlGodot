extends Control
class_name InputDetails

var icon_menu_to_instantiate = load("res://UI/Menu/MenuItemList.tscn")

var ui_info: UIInfo
@onready var cost_label: Label = self.get_node("HBoxContainer/PanelContainer/MarginContainer/cost_label")
var input: ActionInput:
	get: return ui_info.selected_input
var icon_menu: PanelContainer = null
var icon_item_list: ItemList:
	get: return icon_menu.get_node("MarginContainer/VBoxContainer/ItemList")
@onready var icon_button: Button = get_node("HBoxContainer/IconButton")
var ui_field: UIFieldFloat = null

func _ready():
	self.ui_info = find_parent("InputActionCreationMenu")
	icon_button.pressed.connect(on_icon_button_pressed)
	
	self.input.changed.connect(on_input_changed)
	var cooldown_field: FieldFloat = input.fields.filter(func(x): return x.field_name == "cooldown")[0]
	
	ui_field = cooldown_field.instantiate_ui_field()
	ui_field.is_action_parameter = false
	get_node("HBoxContainer").add_child(ui_field)
	ui_field.get_parent().move_child(ui_field, 1)
	
	icon_button.icon = input.icon
	cost_label.text = "Cost : %03d" % self.input.cost

func on_input_changed():
	cost_label.text = "Cost : %03d" % self.input.cost

func on_icon_button_pressed():
	icon_menu = icon_menu_to_instantiate.instantiate()
	icon_menu.gui_input.connect(on_click_outside)
	icon_item_list.item_selected.connect(on_item_selected)
	get_node("/root").add_child(icon_menu)
	for icon in Icons.get_all_textures("inputs"):
		icon_item_list.add_icon_item(icon)

func delete_menu():
	icon_menu.queue_free()
	icon_menu = null

func on_click_outside(input_event: InputEvent):
	if input_event is InputEventMouseButton and input_event.is_pressed():
		delete_menu()

func on_item_selected(index: int):
	input.icon_index = index
	icon_button.icon = input.icon
	
	delete_menu()
