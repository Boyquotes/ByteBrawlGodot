extends Control

var pool: MateriaPool:
	get: return GameInfo.player.materia_pool
var MateriaHUD = load("res://UI/HUD/MateriaHUD.tscn")

@onready var container = self.get_node("container")


const REFRESH_TIME = 1
var current_time = 0

func update_materias():
	var children = container.get_children()
	var children_type = children.map(func (x): return Materia.EType.find_key(x.type))
	var materias = pool.get_child_as_materias()

	for type in materias.keys():
		var number = materias[type].size()
		if number > 0:
			if children_type.has(type):
				children[children_type.find(type)].count = number
			else:
				var instance = MateriaHUD.instantiate()
				instance.init(Materia.EType.get(type), number)
				container.add_child(instance)
		elif children_type.has(type):
			var index = children_type.find(type)
			children[index].queue_free()
			children.remove_at(index)
			children_type.remove_at(index)

func _process(delta_time):
	if not GameInfo.player:
		return
	current_time += delta_time
	if current_time >= REFRESH_TIME:
		current_time = 0
		self.update_materias()

