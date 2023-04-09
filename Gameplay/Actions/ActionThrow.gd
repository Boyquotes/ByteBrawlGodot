class_name ActionThrow
extends Action

enum EItemType {
	ThrowingKnife,
	ThrowingAxe,
}

var item_type: EItemType

# item ptr in inventory, if null take equiped item
var item

func _init(values: Dictionary):
	super._init()
	self.duration = 0.2
	self.allowed_stance = [Sequence.EType.Start, Sequence.EType.Press, Sequence.EType.Release]
	self.block_movement = true
	self.block_action = true
	self.type = EType.cast
	self.item_type = EItemType.get(values["item_type"])


# LOGIC


# UI HELPER
static func get_default_values() -> Dictionary:
	return {"item_type": "ThrowingKnife"}

func get_variables_to_set() -> Array[Field]:
	var item_type_keys = EItemType.keys()
	return [
		ActionsInfo.Enum(
			"item_type",
			"Item Type",
			func(): return item_type_keys[item_type],
			func(x): item_type = EItemType.get(x),
			item_type_keys
		)
	]


# DEBUG
func _to_string() -> String:
	return """THROW | itemType : %s""" % str(self.itemType)
