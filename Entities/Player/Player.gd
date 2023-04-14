class_name Player
extends CharacterBody2D

var gameplay: Gameplay:
	get: return self.get_node("gameplay")

func to_json():
	return {
		"gameplay": gameplay.to_json()
	}

func from_json(data: Dictionary):
	gameplay.from_json(data.gameplay)
