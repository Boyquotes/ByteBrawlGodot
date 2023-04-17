class_name Player
extends RigidBody2D

var gameplay: Gameplay:
	get: return self.get_node("gameplay") if self.has_node("gameplay") else null

var movement: Move:
	get: return self.get_node("movement") if self.has_node("movement") else null

var materia_pool: MateriaPool:
	get: return self.get_node("materia_pool") if self.has_node("materia_pool") else null

var target_locator: BaseNode2D:
	get: return self.get_node("target_locator") if self.has_node("target_locator") else null

# MEMORY
func delete():
	self.gameplay.delete()
	self.queue_free()

func to_json():
	return {
		"gameplay": gameplay.to_json()
	}

func from_json(data: Dictionary):
	gameplay.from_json(data.gameplay)
