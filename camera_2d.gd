extends Camera2D
signal move_mario_to_pipe
@onready var y = global_position.y
@onready var x = global_position.x
@onready var cur_x = global_position.x
func _physics_process(_delta: float) -> void:
	global_position.x = get_node("../Mario").global_position.x
	if global_position.x < cur_x:
		global_position.x = cur_x
	else:
		cur_x = global_position.x

func _on_level_one_camera_stop() -> void:
	set_physics_process(false)
	global_position.x = get_node("../Mario").global_position.x
	for i in range(0, 45):
		global_position.x += 2
		await get_tree().create_timer(0.033).timeout
		
func _on_level_one_camera_move_two() -> void:
	set_physics_process(false)
	for i in range(0, 80):
		global_position.x += 2
		await get_tree().create_timer(0.033).timeout
	move_mario_to_pipe.emit()
