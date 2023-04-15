class_name Field

enum EFieldType
{
	Bool,
	Float,
	Int,
	Enum
}

var field_name: String
var display_name: String
var setter: Callable
var getter: Callable

func get_max_cost(): return null
var max_cost: float:
	get: return get_max_cost()

func get_min_cost(): return null
var min_cost: float:
	get: return get_min_cost()

func get_cost(): return null
var cost: float:
	get: return get_cost()

func _init(field_name: String, display_name: String, getter: Callable, setter: Callable, _args: Array = []):
	self.field_name = field_name
	self.display_name = display_name
	self.getter = getter
	self.setter = setter

func instantiate_ui_field() -> UIField:
	return null

static func Bool(id_name: String, display_name: String, getter: Callable, setter: Callable, cost_discrete: CostDiscrete) -> FieldBool:
	return FieldBool.new(id_name, display_name, getter, setter, [cost_discrete])

static func Int(id_name: String, display_name: String, getter: Callable, setter: Callable, min: int, max: int, cost_curve: CostCurve) -> FieldInt:
	return FieldInt.new(id_name, display_name, getter, setter, [min, max, cost_curve])

static func Float(id_name: String, display_name: String, getter: Callable, setter: Callable, min: float, max: float, cost_curve: CostCurve) -> FieldFloat:
	return FieldFloat.new(id_name, display_name, getter, setter, [min, max, cost_curve])

static func Enum(id_name: String, display_name: String, getter: Callable, setter: Callable, cost_discrete: CostDiscrete) -> FieldEnum:
	return FieldEnum.new(id_name, display_name, getter, setter, [cost_discrete])
