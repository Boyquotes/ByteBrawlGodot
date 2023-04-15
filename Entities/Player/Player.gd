class_name Player
extends CharacterBody2D

@onready var gameplay: Gameplay = self.get_node("gameplay")
@onready var movement: Move = self.get_node("movement")
@onready var materia_pool: MateriaPool = self.get_node("materia_pool")

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
