extends Control

var ui_info: UIInfo
@onready var field_box = self.get_node("HBoxContainer/ScrollContainer/field_box")
@onready var cost_label = self.get_node("HBoxContainer/cost_label")
var input: ActionInput:
	get: return ui_info.selected_input

func _ready():
	self.ui_info = find_parent("InputActionCreationMenu")
	reload()

func reload():
	self.input.connect("changed", on_changed)
	var cooldown_field: FieldFloat = input.fields.filter(func(x): return x.field_name == "cooldown")[0]
	var ui_field: UIFieldFloat = cooldown_field.instantiate_ui_field()
	ui_field.is_action_parameter = false
	
	get_node("HBoxContainer").add_child(ui_field)
	ui_field.get_parent().move_child(ui_field, 1)

func on_changed():
	on_cost_changed()

func on_cost_changed():
	cost_label = str(self.input.cost)

