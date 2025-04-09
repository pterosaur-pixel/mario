extends CharacterBody2D
var x
func _ready() -> void:
	$AnimationPlayer.play("fire")
	global_position.x -= 140
	x = global_position.x - 200
	global_position.y += randf_range(-30, 10)
	velocity.x = -50
	
func _process(delta: float) -> void:
	if global_position.x > x:
		print('moving')
		move_and_slide()
	else:
		#print('past the max')
		queue_free()
