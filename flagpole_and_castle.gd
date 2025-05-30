extends Node2D
signal camera_stop
var number_of_fireworks = 0
var fireworks_scene = preload("res://fireworks.tscn")
var already_started = false

func _process(_delta: float) -> void:
	if TimeLeft.time_left <= 90 and not already_started:
		already_started = true
	if GameStatus.mario_invincible:
		pass
		
func _on_mario_camera_stop() -> void:
	camera_stop.emit()


func _on_mario_mario_in_castle() -> void:
	GameStatus.flagpole = true
	number_of_fireworks = TimeLeft.time_left % 10
	print("fireworks: ", FireworksEarned.fireworks_earned)
	await get_tree().create_timer(3).timeout
	if number_of_fireworks == 1:
		print('fireworking')
		make_fireworks(Vector2(400, 50))
		await get_tree().create_timer(0.7).timeout
	
	if number_of_fireworks == 3:
		make_fireworks(Vector2(400, 50))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(425, 75))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(415, 65))
		await get_tree().create_timer(0.7).timeout
		
	if number_of_fireworks == 6:
		make_fireworks(Vector2(400, 50))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(415, 75))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(405, 65))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(410, 60))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(405, 40))
		await get_tree().create_timer(0.7).timeout
		make_fireworks(Vector2(425, 70))
		await get_tree().create_timer(0.7).timeout
	if Stage.stage == 2:
		GameStatus.theme = 'overworld'
		Stage.stage = 3
		get_tree().paused = false
		$/root/Main.load_level_three()

func make_fireworks(place):
	var fireworks = fireworks_scene.instantiate()
	add_child(fireworks)
	fireworks.global_position = place

func _on_mario_start_playing_regular_music() -> void:
	pass # Replace with function body.


func _on_flagpole_flag_mario_grabbed_pole() -> void:
	already_started = true
	get_tree().paused = true


func _on_flagpole_flag_start_stage_clear_music() -> void:
	pass # Replace with function body.
