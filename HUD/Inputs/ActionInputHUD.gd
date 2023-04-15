extends TextureProgressBar

var input: ActionInput

func init(input: ActionInput):
	self.input = input
	texture_under = input.icon
	texture_progress = input.icon_cooldown

func _process(delta_time):
	print(input.cooldown_percent)
	value = input.cooldown_percent
