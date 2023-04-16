extends ActionSpell
class_name ActionSpellMateriaProjectile

const projectile_life_time_min: float = 10.
const projectile_life_time_max: float = 500.
var projectile_life_time: float = 50.:
	set(x): projectile_life_time = clamp(x, projectile_life_time_min, projectile_life_time_max)

static func get_allowed_sequences(): return [Sequence.EType.started_sequence, Sequence.EType.released_sequence]
static func get_action_name(): return "Materia Projectile"

func _init():
	self.duration = .1
	self.block_action = true
	self.type = EType.cast
	super._init()

# LOGIC
func activate():
	if _owner.target_locator:
		_owner.velocity = _owner.target_locator.position.normalized() * distance / duration

# UI HELPER
func init_fields() -> Array[Field]:
	fields = [
		
	] + super.init_fields()
	return fields

# DEBUG
func _to_string() -> String:
	return """MateriaProjectile | projectile_life_time : %.2f""" % projectile_life_time
