extends CharacterBody2D
var direction = -1
var can_kill_mario = true
var y_max
var y_min
var a = true
signal mario_invincible
signal mushroom_killed_mario
func _ready() -> void:
	$AnimationPlayer.play("flytrap")
	set_z_index(-1)
	velocity.x = 0
	velocity.y = -15
	y_max = global_position.y - 16
	y_min = global_position.y + 5
func _process(delta: float) -> void:
	if a:
		if global_position.y < y_max:
			direction = -direction
			velocity.y = 15 * direction
			move_and_slide()
		elif global_position.y > y_min:
			direction = -direction
			a = false
			await get_tree().create_timer(randf_range(1, 5)).timeout
			a = true
			velocity.y = direction * 15
			move_and_slide()
		move_and_slide()
func _on_kill_mario_body_entered(body: Node2D) -> void:
	if can_kill_mario and not GameStatus.mario_invincible:
		can_kill_mario = false
		set_physics_process(false)
		$KillMario/CollisionShape2D.call_deferred("set_disabled", true)

		if PowerupStatus.powerup_status == 0:
			MarioLives.lives -= 1
			$FireballKill.queue_free()
			$KillMario.queue_free()
			mushroom_killed_mario.emit()	
		else:
			PowerupStatus.powerup_status = 0
			mario_invincible.emit()
			set_physics_process(true)
			$KillMario/CollisionShape2D.call_deferred("set_disabled", false)
		await get_tree().create_timer(1).timeout
		can_kill_mario = true
	elif GameStatus.mario_invincible:
		queue_free()


func _on_fireball_kill_body_entered(body: Node2D) -> void:
	if 'fireball' in body.name:
		Score.score += 200
		queue_free()
