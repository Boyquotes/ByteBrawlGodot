class_name MateriaPool
extends BaseNode

#func _init():
#	for type in Materia.EType:
#		materias[type] = 0

#func hasMaterias(needed: Dictionary):
#	return needed.keys().all(func (key): needed[key] <= materias[key])

#func removeMaterias(toRemove: Dictionary):
#	for key in toRemove.keys():
#		materias[key] = max(materias[key] - max(toRemove[key], 0), 0)



func addMateriaByType(type: Materia.EType):
	self.add_child(Materia.new(type))


func addMateria(materia: Materia):
	self.add_child(materia)


# (<Materia.EType, Int>) -> bool
func removeMaterias(materias: Dictionary) -> bool:
	var children = getChildAsMaterias()
	for key in materias.keys():
		for i in materias[key]:
			var toRemove = (children[key] as Array[Materia]).pop_front() as Materia
			if toRemove:
				toRemove.remove_from_parent()
			else:
				return false
	return true


# (<Materia.EType, Int>) -> bool
func hasMaterias(materias: Dictionary) -> bool:
	var children = getChildAsMaterias()
	return materias.keys().all(func (key): materias[key] <= (children[key] as Array[Materia]).size())


# (void) -> <Materia.EType, Array[Materia]>
func getChildAsMaterias() -> Dictionary:
	var ret = {}
	for type in Materia.EType:
		ret[type] = []
	for child in self.get_children():
		if child is Materia:
			ret[child.type].append(child)
	return ret
