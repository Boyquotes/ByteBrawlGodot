class_name ActionThrow
extends Action

enum EItemType {
	ThrowingKnife,
	ThrowingAxe,
}

const allowed_sequence = [Sequence.EType.started_sequence, Sequence.EType.pressed_sequence, Sequence.EType.released_sequence]
const action_name = "Throw"

var item_type: EItemType = EItemType.ThrowingKnife

# item ptr in inventory, if null take equiped item
var item

func _init():
	self.duration = 0.2
	self.block_movement = true
	self.block_action = true
	self.type = EType.cast
	super._init()

# LOGIC


# UI HELPER
func init_fields():
	var item_type_keys = EItemType.keys()
	fields = [
		Field.Enum(
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
