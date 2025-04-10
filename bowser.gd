extends CharacterBody2D
var can_kill_mario = true
var needs_to_move = true
var fire_scene = preload("res://bowser_fire.tscn")
signal mushroom_killed_mario
signal mario_invincible
func _ready() -> void:
	$Area2D/CollisionPolygon2D.call_deferred("set_disabled", false)
	$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", true)
	$AnimationPlayer.play("bowser-walking_2")
func _process(delta: float) -> void:
	if GameStatus.beat_world_one:
		$AnimationPlayer.stop()
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", true)
func _on_area_2d_body_entered(_body: Node2D) -> void:
	print('MARIO DEAD')
	if can_kill_mario and not GameStatus.mario_invincible and not GameStatus.mario_invincible_bowser:
		needs_to_move = false
		can_kill_mario = false
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", true)

		if PowerupStatus.powerup_status == 0:
			MarioLives.lives -= 1
			$Area2D/CollisionPolygon2D.queue_free()
			$Area2D/CollisionPolygon2D2.queue_free()
			mushroom_killed_mario.emit()
			
		else:
			PowerupStatus.powerup_status = 0
			GameStatus.mario_invincible_bowser = true
			needs_to_move = true
			$Area2D/CollisionPolygon2D.call_deferred("set_disabled", false)
			$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", false)
		await get_tree().create_timer(1).timeout
		can_kill_mario = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if anim_name == "bowser-walking" and needs_to_move and not GameStatus.beat_world_one:
		print('hi')
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", true)
		$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", false)
		var fire_y = global_position.y + randf_range(-20, 10)
		for i in range(0, randf_range(1, 3)):
			var fire = fire_scene.instantiate()
			add_child(fire)
			fire.global_position.y = fire_y
			await get_tree().create_timer(0.6).timeout
		$AnimationPlayer.play("bowser-walking_2")
		$Sprite2D.flip_h = true
	elif needs_to_move and not GameStatus.beat_world_one:
		print('hello bowser')
		$Area2D/CollisionPolygon2D.call_deferred("set_disabled", false)
		$Area2D/CollisionPolygon2D2.call_deferred("set_disabled", true)
		$AnimationPlayer.play("bowser-walking")
		$Sprite2D.flip_h = false
