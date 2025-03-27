extends Label
func _ready() -> void:
	set_process(false)
func _process(delta: float) -> void:
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
	

func _on_game_start_start_game() -> void:
	$Timer.start()
	

func _on_level_one_timer_countdown() -> void:
	set_process(true)
