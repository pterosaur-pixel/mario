extends Camera2D
@onready var y = global_position.y
@onready var x = global_position.x
@onready var cur_x = global_position.x
func _physics_process(_delta: float) -> void:
	global_position.x = get_node("../LevelOne/Mario").global_position.x
	"""if global_position.x < cur_x:
		print('camera moved')
	cur_x = global_position.x"""

	
