extends CharacterBody2D
var current_powerup = 0
var direction = 1
func _ready() -> void:
	set_process(false)
	$AnimationPlayer.play("growing-mushroom")
	await get_tree().create_timer(0.75).timeout
	set_process(true)
	
	
func _process(delta: float) -> void:	
	pass
	set_z_index(0)
	if current_powerup == 0:
		if not is_on_floor():
			velocity.y += 1250 * delta
		elif velocity.x == 0:
			direction = -direction
		velocity.x = direction * 35
		$AnimationPlayer.play("mushroom")
	elif current_powerup == 1:
		$AnimationPlayer.play("flower")
	move_and_slide() 
