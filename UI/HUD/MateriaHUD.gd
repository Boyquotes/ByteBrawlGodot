extends Control

var count_label: Label
var name_label: Label
var icon: TextureRect

var type: Materia.EType:
	set(x): name_label.text = Materia.EType.find_key(x); icon.texture = MateriaList.get_icon_path(x); type = x

var count: int:
	set(x): count_label.text = str(x); count = x

func init(type: Materia.EType, count = 1):
	count_label = self.get_node("container/count")
	name_label = self.get_node("container/name")
	icon = self.get_node("container/icon")
	self.type = type
	self.count = count

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
