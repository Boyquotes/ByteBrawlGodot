extends Node
var scene_path: Dictionary

func dir_contents(path: String):
	var dir = DirAccess.open(path)
	if not dir: return
	dir.list_dir_begin()
	while add_spell_to_path(dir.get_next(), path): pass

func add_spell_to_path(name: String, path: String) -> bool:
	if name == "": return false
	var key = name.replace(".tscn", "").replace("Spell", "")
	scene_path[key] = "%s/%s" % [ path, name ]
	return true

func init_spells_path():
	dir_contents("res://Entities/Spells/")

func _init():
	init_spells_path()

