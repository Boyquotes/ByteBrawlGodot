extends VBoxContainer

var pool: MateriaPool


func _process(delta_time):
	if not PlayerInfo.player:
		return
	if not pool:
		pool = PlayerInfo.player.get_node("materia_pool")


