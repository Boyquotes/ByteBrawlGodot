extends TextureProgressBar

var input: ActionInput

func init(input: ActionInput):
	self.input = input
	texture_under = input.icon
	texture_progress = input.icon
	max_value = input.cooldown_timer.wait_time * 100

func _process(delta_time):
	if not input.cooldown_timer.time_left: return
	value = input.cooldown_timer.time_left * 100
