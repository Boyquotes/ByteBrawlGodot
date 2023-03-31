class_name ActionThrow
extends Action

enum EItemType {
	ThrowingKnife,
	ThrowingAxe,
}

var itemType: EItemType

# item ptr in inventory, if null take equiped item
var item

func _init(itemType: EItemType):
	super._init()
	self.duration = 0.2
	self.allowed_stance = [Sequence.EType.Start, Sequence.EType.Press, Sequence.EType.Release]
	self.block_movement = true
	self.block_action = true
	self.type = EType.cast
	self.itemType = itemType


# LOGIC


# UI HELPER
func get_variables_to_set() -> Array[ActionParameterField]:
	return [
		EnumParameterField.new("itemType", [
			EItemType.ThrowingKnife,
			EItemType.ThrowingAxe,
		])
	]


# DEBUG
func _to_string() -> String:
	return """THROW | itemType : %s""" % str(self.itemType)
