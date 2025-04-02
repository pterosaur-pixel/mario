extends Label
var is_scene = preload("res://intermission_screen.tscn")

	

func _process(_delta: float) -> void:
	if GameStatus.flagpole:
		TimeLeft.time_left -= 1
		if TimeLeft.time_left < 0:
			print('game_over')
			$Timer.stop()
			hide()
			set_process(false)
		if TimeLeft.time_left < 10:
			text = '00'+str(TimeLeft.time_left)
		elif TimeLeft.time_left < 100:
			text = '0'+str(TimeLeft.time_left)
		else:
			text = str(TimeLeft.time_left)
		$AudioStreamPlayer.play(0.02)
		Score.score += 50
		#await get_tree().create_timer(0.01).timeout
		
func _on_timer_timeout() -> void:
	TimeLeft.time_left -= 1
	if TimeLeft.time_left < 0:
		$Timer.stop()
		MarioLives.lives -= 1
		if MarioLives.lives <= 0:
			$/root/Main.exit_level()
			$TimeoutScreen.show()
			await get_tree().create_timer(2).timeout
			$TimeoutScreen.hide()
			GameStatus.ready_for_game_over = true
			
			
		else:
			$/root/Main.exit_level()
			$TimeoutScreen.show()
			await get_tree().create_timer(2).timeout
			$TimeoutScreen.hide()
			PowerupStatus.powerup_status = 0 
			GameStatus.mario_invincible = false
			
			if World.world == 1:
				if Stage.stage == 1:
					$/root/Main.reload_level_one()
				elif Stage.stage == 2:
					$/root/Main.reload_level_two()
				elif Stage.stage == 3:
					$/root/Main.load_level_three()


	if TimeLeft.time_left < 10:
		text = '00'+str(TimeLeft.time_left)
	elif TimeLeft.time_left < 100:
		text = '0'+str(TimeLeft.time_left)
	else:
		text = str(TimeLeft.time_left)

func _on_main_start_timer() -> void:
	$Timer.stop()
	print("starting timer")
	TimeLeft.time_left = 300
	text = str(300)
	show()
	await get_tree().create_timer(2).timeout
	$Timer.start()
	set_process(true)
	
