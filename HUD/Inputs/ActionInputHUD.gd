extends TextureProgressBar

var input: ActionInput

var is_on_cooldown = false

func init(input: ActionInput):
	self.input = input
	texture_under = input.cooldown_icon
	texture_over = input.icon


func _process(delta_time):
	value = input.cooldown_percent
