extends CharacterBody2D
var current_powerup = PowerupStatus.powerup_status
var direction = 1
var star_velocity = randf_range(-450.0, -250.0)
var type_of_powerup = 0
func _ready() -> void:
	if type_of_powerup == 0:
		set_process(false)
		if current_powerup == 0:
			$AnimationPlayer.play("growing-mushroom")
			await get_tree().create_timer(0.75).timeout
		set_process(true)
	elif type_of_powerup == 2:
		set_process(false)
		$AnimationPlayer.play("one-up-growing")
		await get_tree().create_timer(0.75).timeout
		set_process(true)
	elif type_of_powerup == 1:
		velocity.y = star_velocity
		set_process(false)
		$AnimationPlayer.play("star-growing")
		await get_tree().create_timer(0.8).timeout
		set_process(true)
	
	
func _process(delta: float) -> void:
	if type_of_powerup == 0:
		current_powerup = PowerupStatus.powerup_status
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
	elif type_of_powerup == 1:
		set_z_index(0)
		if not is_on_floor():
			velocity.y += 1250 * delta
		elif is_on_floor():
			velocity.y = star_velocity
		elif velocity.x == 0:
			direction = -direction
		velocity.x = direction * 45
		$AnimationPlayer.play("star")
		move_and_slide()
	elif type_of_powerup == 2:
		set_z_index(0)
		if not is_on_floor():
			velocity.y += 1250 * delta
		elif velocity.x == 0:
			direction = -direction
		velocity.x = direction * 35
		$AnimationPlayer.play("one-up")
		move_and_slide()
		

func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	print('caught')
	$AudioStreamPlayer2.play()
	if type_of_powerup == 0:
		print('Mario got mushroom powerup!')
		PowerupStatus.powerup_status += 1
		current_powerup = PowerupStatus.powerup_status
		print(current_powerup, 'cur_pow')
		set_process(false)
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled",true)
		Score.score += 1000
		hide()
	elif type_of_powerup == 1:
		GameStatus.mario_invincible = true
		set_process(false)
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled",true)
		Score.score += 1000
		hide()
	elif type_of_powerup == 2:
		MarioLives.lives += 1
		set_process(false)
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled",true)
		hide()
func _on_audio_stream_player_2_finished() -> void:
	queue_free()
