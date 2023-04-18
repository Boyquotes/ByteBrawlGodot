class_name ActionSpell
extends Action

var _spell
var spell_name: String:
	set(x):
		_spell = load(Spells.scene_path[x])
		spell_name = x

static func get_allowed_sequences(): return [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
static func get_action_name(): return "Spell"

func _init():
	self.duration = .1
	self.block_action = true
	self.type = EType.cast
	super._init()

# LOGIC
func activate():
	if _owner.target_locator:
		var new_spell = _spell.instantiate()
		get_node("/root").add_child(new_spell)
		new_spell.init(_owner, _owner.position, _owner.target_locator.position.normalized(), 20)

# UI HELPER
func init_fields():
	fields = [
		Field.Enum(
			"spell",
			"Spell",
			func(): return spell_name,
			func(x): spell_name = x,
			CostDiscrete.init_same_values(Spells.scene_path.keys(), 1.)
		)
	]

# DEBUG
func _to_string() -> String:
	return """Spell | spell : %s""" % _spell
