class_name MateriaPool
extends BaseNode

func add_materia_by_type(type: Materia.EType):
	self.add_child(Materia.new(type))


func add_materia(materia: Materia):
	self.add_child(materia)

# (<Materia.EType, Int>) -> bool
func remove_materias(materias: Dictionary) -> bool:
	var children = get_child_as_materias()
	for key in materias.keys():
		for i in materias[key]:
			var toRemove = (children[key] as Array[Materia]).pop_front() as Materia
			if toRemove:
				toRemove.remove_from_parent()
			else:
				return false
	return true

# (<Materia.EType, Int>) -> bool
func has_materias(materias: Dictionary) -> bool:
	var children = get_child_as_materias()
	return materias.keys().all(func (key): materias[key] <= (children[key] as Array[Materia]).size())


# (void) -> <Materia.EType, Array[Materia]>
func get_child_as_materias() -> Dictionary:
	var ret = {}
	for type in Materia.EType:
		ret[type] = []
	for child in self.get_children():
		if child is Materia:
			ret[Materia.EType.find_key(child.type)].append(child)
	return ret
