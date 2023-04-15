extends MarginContainer

var input: ActionInput
@onready var field_box = self.get_node("HBoxContainer/ScrollContainer/field_box")
@onready var cost_label = self.get_node("HBoxContainer/cost_label")

func init(input: ActionInput):
	self.input = input
	self.input.connect("changed", on_changed)

func _ready():
	for field in self.input.fields:
		field_box.add_child(field.instantiate_ui_field())


func on_changed():
	on_cost_changed()

func on_cost_changed():
	cost_label = str(self.input.cost)

