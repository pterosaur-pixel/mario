extends RigidBody2D
func _process(_delta: float) -> void:
	print(global_position.x, get_node("../Mario").global_position.x)
	global_position.x = get_node("../L2Camera").global_position.x - 35
