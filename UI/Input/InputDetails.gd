extends Control

var ui_info: UIInfo
@onready var cost_label: Label = self.get_node("HBoxContainer/PanelContainer/MarginContainer/cost_label")
var input: ActionInput:
	get: return ui_info.selected_input
@onready var icon: MenuButton = get_node("HBoxContainer/Icon")
@onready var icon_popup: PopupMenu = icon.get_popup()
@onready var icon_cooldown: MenuButton = get_node("HBoxContainer/IconCooldown")
@onready var icon_cooldown_popup: PopupMenu = icon_cooldown.get_popup()

func _ready():
	self.ui_info = find_parent("InputActionCreationMenu")
	icon_popup.id_pressed.connect(on_icon_pressed)
	icon_cooldown_popup.id_pressed.connect(on_icon_cooldown_pressed)
	
	for icon in Icons.get_all_textures("inputs"):
		icon_popup.add_icon_item(icon, "")
		icon_cooldown_popup.add_icon_item(icon, "")
		
	reload()

func reload():
	self.input.changed.connect(on_input_changed)
	var cooldown_field: FieldFloat = input.fields.filter(func(x): return x.field_name == "cooldown")[0]
	var ui_field: UIFieldFloat = cooldown_field.instantiate_ui_field()
	ui_field.is_action_parameter = false
	get_node("HBoxContainer").add_child(ui_field)
	ui_field.get_parent().move_child(ui_field, 2)
	icon.icon = input.icon
	icon_cooldown.icon = input.icon_cooldown

func on_input_changed():
	cost_label.text = "Cost : %03d" % self.input.cost

func on_icon_pressed(item_index: int):
	input.icon_index = item_index
	icon.icon = input.icon

func on_icon_cooldown_pressed(item_index: int):
	input.icon_cooldown_index = item_index
	icon_cooldown.icon = input.icon_cooldown
