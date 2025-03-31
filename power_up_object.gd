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
		$Sprite2D.hide()
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled",true)
		Score.score += 1000
		$PointLabel.show()
		await get_tree().create_timer(1).timeout
		hide()
	elif type_of_powerup == 1:
		GameStatus.mario_invincible = true
		$Sprite2D.hide()
		set_process(false)
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled",true)
		$PointLabel.show()
		Score.score += 1000
		await get_tree().create_timer(1).timeout
		hide()
	elif type_of_powerup == 2:
		$PointLabel.text = "1 UP"
		MarioLives.lives += 1
		GameStatus.one_up_gettable = false
		set_process(false)
		$Sprite2D.hide()
		$PointLabel.show()
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled",true)
		await get_tree().create_timer(1).timeout
		hide()
func _on_audio_stream_player_2_finished() -> void:
	queue_free()


func _on_brick_moved_collider_area_entered(area: Area2D) -> void:
	print('hit by a brick', direction)
	direction = -direction
	velocity.x = direction * 35
	print(direction)
