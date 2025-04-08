extends CharacterBody2D
var can_kill_mario = true
signal mushroom_killed_mario
signal mario_invincible
func _ready() -> void:
	$Area2D/CollisionPolygon2D.call_deferred("set_disabled", false)
	$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", true)
	$AnimationPlayer.play("bowser-walking_2")
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	if can_kill_mario and not GameStatus.mario_invincible:
		can_kill_mario = false
		set_physics_process(false)
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", true)

		if PowerupStatus.powerup_status == 0:
			MarioLives.lives -= 1
			$Area2D/CollisionPolygon2D.queue_free()
			$Area2D/CollisionPolygon2D2.queue_free()
			mushroom_killed_mario.emit()
			
		else:
			PowerupStatus.powerup_status = 0
			mario_invincible.emit()
			set_physics_process(true)
			$Area2D/CollisionPolygon2D.call_deferred("set_disabled", false)
			$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", false)
		await get_tree().create_timer(1).timeout
		can_kill_mario = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if anim_name == "bowser-walking":
		print('hi')
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", false)
		$AnimationPlayer.play("bowser-walking_2")
		$Sprite2D.flip_h = true
	else:
		print('hello bowser')
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", false)
		$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", true)
		$AnimationPlayer.play("bowser-walking")
		$Sprite2D.flip_h = false
