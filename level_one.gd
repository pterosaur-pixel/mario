extends Node2D
signal grow_mushroom1
signal mushroom_killed_mario_l1
signal mario_should_jumpl1
signal game_over_l1
signal start_game
signal fall_collider_entered
signal camera_stop
signal camera_go
signal timer_countdown
signal show_underground_room_1
var fireworks_scene = preload("res://fireworks.tscn")
var number_of_fireworks

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_mushroom_brick_mushroom_1_hit() -> void:
	print('HIT')
	grow_mushroom1.emit()

func _on_mushroom_mario_should_jump() -> void:
	mario_should_jumpl1.emit()


func _on_mushroom_mushroom_killed_mario() -> void:
	mushroom_killed_mario_l1.emit()
	print("dead mario")
	
	


func _on_mario_game_over() -> void:
	set_physics_process(false)
	
	get_tree().reload_current_scene()
	#get_tree().paused = false
	game_over_l1.emit()
func _on_game_start_start_game() -> void:
	start_game.emit()
	
	


func _on_fall_collider_body_entered(_body: Node2D) -> void:
	fall_collider_entered.emit()


func _on_mario_should_jumpl_1() -> void:
	pass # Replace with function body.


func _on_mario_camera_stop() -> void:
	camera_stop.emit()


func _on_mario_camera_go() -> void:
	camera_go.emit()


func _on_flagpole_flag_mario_grabbed_pole() -> void:
	get_tree().paused = true
	
	
	#$Mario.play()
	#$FlagpoleFlag.play()


func _on_mario_mario_in_castle() -> void:
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
	hide()
	$Mario.call_deferred("set_physics_process", false)
	show_underground_room_1.emit()
