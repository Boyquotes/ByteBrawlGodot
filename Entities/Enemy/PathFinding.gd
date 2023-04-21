extends NavigationAgent2D
class_name PathFinding

@onready var agent: KinematicCharacterBody = get_parent()

func _physics_process(delta_time):
	target_position = GameInfo.player.global_position
	
#	print(target_position)
	
	if is_target_reachable():
		agent.direction = get_next_path_position() - agent.global_position
