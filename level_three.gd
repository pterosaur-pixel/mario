class_name LevelThree
extends Node2D
signal mushroom_killed_mario_l1
signal mario_should_jumpl1
signal start_game
signal fall_collider_entered
signal camera_stop
signal camera_go
signal timer_countdown
signal camera_move_two
var fireworks_scene = preload("res://fireworks.tscn")
var number_of_fireworks
var mario_underground = false
var already_started = false

func _ready() -> void:
	if GameStatus.got_checkpoint:
		#pass
		$IntermissionScreen.global_position = Vector2($MarioStart2.global_position.x + 5, $MarioStart2.global_position.y + 50)
		$Mario.global_position = $MarioStart2.global_position
	else:
		#pass
		$Mario.global_position = $MarioStart1.global_position
		$IntermissionScreen.global_position = Vector2($MarioStart1.global_position.x + 5, $MarioStart1.global_position.y + 100)
	$Mario.set_physics_process(false)
	GameStatus.flagpole = false
	set_physics_process(false)
	$IntermissionScreen.show()
	await get_tree().create_timer(2).timeout
	$IntermissionScreen.queue_free()
	start_game.emit()
	$Mario.set_physics_process(true)
	#$AudioStreamPlayer2.play()
	

func _process(_delta: float) -> void:
	if TimeLeft.time_left <= 90 and not mario_underground and not already_started:
		#$AudioStreamPlayer2.stop()
		#$AudioStreamPlayer4.play()
		already_started = true
	if GameStatus.mario_invincible:
		pass
	if $Mario.global_position.x > $MarioStart2.global_position.x:
		GameStatus.got_checkpoint = true
		#$AudioStreamPlayer2.stop()
	
	

#func _on_mushroom_brick_mushroom_1_hit() -> void:
#	print('HIT')
#	grow_mushroom1.emit()

func _on_mushroom_mario_should_jump() -> void:
	mario_should_jumpl1.emit()


func _on_mushroom_mushroom_killed_mario() -> void:
	mushroom_killed_mario_l1.emit()
	#$AudioStreamPlayer2.stop()
	#$AudioStreamPlayer3.stop()
	#$AudioStreamPlayer4.stop()
	print("dead mario")
	
	


func _on_mario_game_over() -> void:
	print(MarioLives.lives, "lives remaining")
	if MarioLives.lives == 0:
		print('Game Over and fish sticks for all')
		#Score.score = 0
		#CoinCount.coin_count = 0
		#PowerupStatus.powerup_status = 0 
		#GameStatus.mario_invincible = false
		
		GameStatus.ready_for_game_over = true
		queue_free()
	else:
		PowerupStatus.powerup_status = 0 
		GameStatus.mario_invincible = false
		$/root/Main.load_level_three()
		
func _on_game_start_start_game() -> void:
	pass
	
func _on_fall_collider_body_entered(_body: Node2D) -> void:
	#fall_collider_entered.emit()
	MarioLives.lives -= 1
	if MarioLives.lives <= 0:
		#print('Mario is dead by falling')
		#Score.score = 0
		#CoinCount.coin_count = 0
		#PowerupStatus.powerup_status = 0 
		#GameStatus.mario_invincible = false
		GameStatus.ready_for_game_over = true
		queue_free()
	else:
		PowerupStatus.powerup_status = 0 
		GameStatus.mario_invincible = false
		$/root/Main.load_level_three()
		
	

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
	await get_tree().create_timer(1).timeout
	$/root/Main.load_level_four()
	
func make_fireworks(place):
	var fireworks = fireworks_scene.instantiate()
	add_child(fireworks)
	fireworks.global_position = place


func _on_flagpole_flag_start_stage_clear_music() -> void:
	pass
	#$AudioStreamPlayer.play()


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
		await get_tree().create_timer(0.7).timeout
		
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
		await get_tree().create_timer(0.7).timeout
		
	camera_move_two.emit()





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
		
		#$AudioStreamPlayer3.stop()
		#$AudioStreamPlayer2.play()

		


func _on_main_start_l_1() -> void:
	pass
	#$AudioStreamPlayer2.play()


func _on_mario_start_playing_regular_music() -> void:
	pass
	#$AudioStreamPlayer2.play()


func _on_camera_2d_move_mario_to_pipe() -> void:
	$Mario.show()
	if PowerupStatus.powerup_status == 0:
		$Mario/AnimationPlayer.play("mario-little-running")
	if PowerupStatus.powerup_status == 1:
		$Mario/AnimationPlayer.play("mario-running")
	if PowerupStatus.powerup_status >= 2:
		$Mario/AnimationPlayer.play("mario-powerup-running")
	for i in range(0, 55):
		$Mario.global_position.x += 2
		await get_tree().create_timer(0.033).timeout
	$Mario.set_z_index(-1)
	$Mario/AudioStreamPlayer2.play()
	$Mario.global_position.y -= 3
	for i in range(0, 20):
		$Mario.global_position.x += 1
		await get_tree().create_timer(0.033).timeout
	$Mario.hide()
	Stage.stage = 2
	GameStatus.theme = 'underground'
	get_tree().paused = false
	$/root/Main.load_world_one_stage_two()
