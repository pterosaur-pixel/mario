extends RigidBody2D
@onready var y = global_position.y
func _process(_delta: float) -> void:
	global_position.y = y
