extends ActionSpell
class_name ActionSpellMateriaProjectile

var materia_projectile_to_instantiate = load("res://Entities/Area/MateriaProjectile.tscn")

const projectile_speed_min: float = 10.
const projectile_speed_max: float = 500.
var projectile_speed: float = 50.:
	set(x): projectile_speed = clamp(x, projectile_speed_min, projectile_speed_max)

const projectile_travel_distance_min: float = 10.
const projectile_travel_distance_max: float = 500.
var projectile_travel_distance: float = 100.:
	set(x): projectile_travel_distance = clamp(x, projectile_travel_distance_min, projectile_travel_distance_max)

const projectile_size_min: float = .5
const projectile_size_max: float = 10.
var projectile_size: float = 1.:
	set(x): projectile_size = clamp(x, projectile_size_min, projectile_size_max)

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
		var materia_projectile: MateriaProjectile = materia_projectile_to_instantiate.instantiate()
		materia_projectile.init(
			_owner,
			_owner.position,
			_owner.target_locator.position.normalized() * projectile_speed,
			projectile_travel_distance / projectile_speed,
			projectile_size,
			MateriaList.get_icon_texture(materia_type)
		)
		materia_projectile.add_child(EjectProjectile.new())
		
		get_node("/root").add_child(materia_projectile)

# UI HELPER
func init_fields():
	super.init_fields()
	
	fields.append_array([
		Field.Float(
			"projectile_speed",
			"Projectile Speed",
			func(): return projectile_speed,
			func(x): projectile_speed = x,
			projectile_speed_min,
			projectile_speed_max,
			CostCurve.new(1., 20., CostCurve.EMode.Exponential)
		),
		Field.Float(
			"projectile_travel_distance",
			"Projectile Travel Distance",
			func(): return projectile_travel_distance,
			func(x): projectile_travel_distance = x,
			projectile_travel_distance_min,
			projectile_travel_distance_max,
			CostCurve.new(1., 20., CostCurve.EMode.Exponential)
		),
		Field.Float(
			"projectile_size",
			"Projectile Size",
			func(): return projectile_size,
			func(x): projectile_size = x,
			projectile_size_min,
			projectile_size_max,
			CostCurve.new(1., 20., CostCurve.EMode.Exponential)
		)
	])

# DEBUG
func _to_string() -> String:
	return """MateriaProjectile | projectile_life_time : %.2f""" % projectile_travel_distance
