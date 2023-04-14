class_name FieldBool
extends Field

var button: CheckButton
var cost_discrete: CostDiscrete

func _get_cost(): return cost_discrete.eval(getter.call())

func init(field_name: String, pretty_name: String, getter: Callable, setter: Callable, _args: Array = []):
	(get_node("Panel/Label") as Label).text = pretty_name
	button = get_node("FieldBool") 
	super.init(field_name, pretty_name, getter, setter)

func _ready():
	button.button_pressed = getter.call()

func _on_pressed():
	update_value(not getter.call())

func update_value(updated_value):
	super.update_value(updated_value)
	button.button_pressed = getter.call()

