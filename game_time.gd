extends Label
	
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
	
