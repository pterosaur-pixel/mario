extends Label
var is_scene = preload("res://intermission_screen.tscn")

	

func _process(_delta: float) -> void:
	if GameStatus.flagpole:
		TimeLeft.time_left -= 1
		if TimeLeft.time_left < 0:
			print('game_over')
			queue_free()
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
		print('game_over')
		queue_free()
	if TimeLeft.time_left < 10:
		text = '00'+str(TimeLeft.time_left)
	elif TimeLeft.time_left < 100:
		text = '0'+str(TimeLeft.time_left)
	else:
		text = str(TimeLeft.time_left)

func _on_main_start_timer() -> void:
	$Timer.stop()
	TimeLeft.time_left = 300
	text = str(300)
	await get_tree().create_timer(2).timeout
	$Timer.start()
	
