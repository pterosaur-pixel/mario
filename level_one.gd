class_name LevelOne
extends Node2D
signal mushroom_killed_mario_l1
signal mario_should_jumpl1

signal start_game
signal fall_collider_entered
signal camera_stop
signal camera_go
signal timer_countdown
var fireworks_scene = preload("res://fireworks.tscn")
var number_of_fireworks
var mario_underground = false
var already_started = false

func _ready() -> void:
	GameStatus.flagpole = false
	set_physics_process(false)
	$IntermissionScreen.show()
	await get_tree().create_timer(2).timeout
	$IntermissionScreen.queue_free()
	start_game.emit()
	$AudioStreamPlayer2.play()
	

func _process(_delta: float) -> void:
	if TimeLeft.time_left <= 90 and not mario_underground and not already_started:
		$AudioStreamPlayer2.stop()
		$AudioStreamPlayer4.play()
		already_started = true
	if GameStatus.mario_invincible:
		$AudioStreamPlayer2.stop()
	
	

#func _on_mushroom_brick_mushroom_1_hit() -> void:
#	print('HIT')
#	grow_mushroom1.emit()

func _on_mushroom_mario_should_jump() -> void:
	mario_should_jumpl1.emit()


func _on_mushroom_mushroom_killed_mario() -> void:
	mushroom_killed_mario_l1.emit()
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer4.stop()
	
	
	
	print("dead mario")
	
	


func _on_mario_game_over() -> void:
	print(MarioLives.lives, "lives remaining")
	if MarioLives.lives == 0:
		print('Game Over and fish sticks for all')
		Score.score = 0
		CoinCount.coin_count = 0
		PowerupStatus.powerup_status = 0 
		GameStatus.mario_invincible = false
		queue_free()
	else:
		GameStatus.mario_invincible = false
		$/root/Main.reload_level_one()
		#reload_level_one.emit()
		#queue_free()
		
		#get_tree().change_scene_to_file("res://level_one.tscn")
		#get_tree().call_deferred("change_scene_to_file", "res://level_one.tscn")
		
		#get_tree().reload_current_scene()
		#print(MarioLives.lives)
		#start_game.emit()
		
	#get_tree().paused = false
		
func _on_game_start_start_game() -> void:
	pass
	
func _on_fall_collider_body_entered(_body: Node2D) -> void:
	fall_collider_entered.emit()
	MarioLives.lives -= 1
	if MarioLives.lives == 0:
		Score.score = 0
		CoinCount.coin_count = 0
	PowerupStatus.powerup_status = 0
	GameStatus.mario_invincible = false
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer4.stop()
	$/root/Main.reload_level_one()

func _on_mario_should_jumpl_1() -> void:
	pass # Replace with function body.


func _on_mario_camera_stop() -> void:
	camera_stop.emit()


func _on_mario_camera_go() -> void:
	camera_go.emit()


func _on_flagpole_flag_mario_grabbed_pole() -> void:
	already_started = true
	get_tree().paused = true
	
	
	
	#$Mario.play()
	#$FlagpoleFlag.play()


func _on_mario_mario_in_castle() -> void:
	GameStatus.flagpole = true
	number_of_fireworks = TimeLeft.time_left % 10
	timer_countdown.emit()
	
	print("fireworks: ", FireworksEarned.fireworks_earned)
	
func make_fireworks(place):
	var fireworks = fireworks_scene.instantiate()
	add_child(fireworks)
	fireworks.global_position = place


func _on_flagpole_flag_start_stage_clear_music() -> void:
	$AudioStreamPlayer.play()


func _on_audio_stream_player_finished() -> void:
	if number_of_fireworks == 1:
		print('fireworking')
		make_fireworks(Vector2(1250, 50))
		await get_tree().create_timer(0.7).timeout
	
	if number_of_fireworks == 3:
		make_fireworks(Vector2(1250, 50))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(1225, 75))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(1275, 65))
		
	if number_of_fireworks == 6:
		make_fireworks(Vector2(1250, 50))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(1225, 75))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(1275, 65))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(1270, 60))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(1235, 40))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(1295, 70))


func _on_portal_to_underground_mario_to_underground() -> void:
	mario_underground = true
	$Mario.call_deferred("set_physics_process", false)
	$Mario.set_z_index(-1)
	for i in range(0, 20):
		$Mario.global_position.y += 1
		await get_tree().create_timer(0.033).timeout
	#hide()
	$/root/Main.load_level_one_underground()
#	$AudioStreamPlayer3.play()
	$AudioStreamPlayer2.stop()



func _on_underground_room_underground_room_exited() -> void:
	pass


func _on_tree_entered() -> void:
	print('entered')
	if mario_underground:
		print('leaving underground')
		mario_underground = false
		
		show()
		$Mario.global_position = $MarioEmergeMarker.global_position
		
		if PowerupStatus.powerup_status == 0:
			$Mario/AnimationPlayer.play("mario-little-idle")
		if PowerupStatus.powerup_status == 1:
			$Mario/AnimationPlayer.play("mario-idle")
		if PowerupStatus.powerup_status >= 2:
			$Mario/AnimationPlayer.play("mario-powerup-idle")
		
		for i in range(0, 20):
			$Mario.global_position.y -= 1
			await get_tree().create_timer(0.033).timeout
		$Mario.set_physics_process(true)
		
		$AudioStreamPlayer3.stop()
		$AudioStreamPlayer2.play()

		


func _on_main_start_l_1() -> void:
	$AudioStreamPlayer2.play()


func _on_mario_start_playing_regular_music() -> void:
	$AudioStreamPlayer2.play()
