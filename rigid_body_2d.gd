extends RigidBody2D
func _process(delta: float) -> void:
	global_position.x = get_node("../Camera2D").global_position.x - 35
