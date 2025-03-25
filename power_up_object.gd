extends CharacterBody2D
var current_powerup = PowerupStatus.powerup_status
var direction = 1
func _ready() -> void:
	set_process(false)
	if current_powerup == 0:
		$AnimationPlayer.play("growing-mushroom")
		await get_tree().create_timer(0.75).timeout
	set_process(true)
	
	
func _process(delta: float) -> void:	
	
	
	set_z_index(0)
	if current_powerup == 0:
		if not is_on_floor():
			velocity.y += 1250 * delta
		elif velocity.x == 0:
			direction = -direction
		velocity.x = direction * 35
		$AnimationPlayer.play("mushroom")
	elif current_powerup >= 1:
		velocity = Vector2(0, 0)
		
		$AnimationPlayer.play("flower")
	move_and_slide() 


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	print('Mario got mushroom powerup!')
	PowerupStatus.powerup_status += 1
	MarioLifeLeft.lifeleft += 1
	current_powerup = PowerupStatus.powerup_status
	print(current_powerup, 'cur_pow')
	set_process(false)
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Area2D/CollisionPolygon2D.call_deferred("set_disabled",true)
	Score.score += 1000
	hide()
func _on_point_label_done_displaying() -> void:
	queue_free()
