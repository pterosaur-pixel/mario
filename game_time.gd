extends Label
var time = 300
	
func _on_timer_timeout() -> void:
	time = time - 1
	if time < 0:
		print('game_over')
		queue_free()
	if time < 10:
		text = '00'+str(time)
	elif time < 100:
		text = '0'+str(time)
	else:
		text = str(time)

func _on_game_start_start_game() -> void:
	$Timer.start()
	
