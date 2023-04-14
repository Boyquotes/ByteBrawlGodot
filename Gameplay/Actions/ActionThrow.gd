class_name ActionThrow
extends Action

enum EItemType {
	ThrowingKnife,
	ThrowingAxe,
}

const allowed_sequence = [Sequence.EType.started_sequence, Sequence.EType.pressed_sequence, Sequence.EType.released_sequence]
const display_name = "Throw"


var item_type: EItemType

# item ptr in inventory, if null take equiped item
var item

func _init(item_type: EItemType):
	super._init()
	self.duration = 0.2
	self.block_movement = true
	self.block_action = true
	self.type = EType.cast
	self.item_type = item_type


# LOGIC


# UI HELPER
func get_display_name():
	return self.display_name

static func get_default_values() -> Dictionary:
	return { "item_type": "ThrowingKnife" }

static func new_from_json(values: Dictionary):
	return ActionThrow.new(EItemType.get(values["item_type"]))

func set_fields() -> Array[Field]:
	var item_type_keys = EItemType.keys()
	return [
		ActionsInfo.Enum(
			"item_type",
			"Item Type",
			func(): return item_type_keys[item_type],
			func(x): item_type = EItemType.get(x),
			CostDiscrete.init_same_values(item_type_keys, 1.)
		)
	]


# DEBUG
func _to_string() -> String:
	return """THROW | itemType : %s""" % str(self.itemType)
