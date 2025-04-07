class_name LevelFour
extends Node2D
signal start_game
signal camera_stop
signal camera_go
#var fireworks_scene = preload("res://fireworks.tscn")
#var number_of_fireworks
var mario_underground = false
var already_started = false

func _ready() -> void:
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


func _on_mario_game_over() -> void:
	print(MarioLives.lives, "lives remaining")
	if MarioLives.lives == 0:
		print('Game Over and fish sticks for all')
		GameStatus.ready_for_game_over = true
		queue_free()
	else:
		PowerupStatus.powerup_status = 0 
		GameStatus.mario_invincible = false
		$/root/Main.load_level_four()
		
func _on_game_start_start_game() -> void:
	pass
	
func _on_fall_collider_body_entered(_body: Node2D) -> void:
	MarioLives.lives -= 1
	if MarioLives.lives <= 0:
		GameStatus.ready_for_game_over = true
		queue_free()
	else:
		PowerupStatus.powerup_status = 0 
		GameStatus.mario_invincible = false
		$/root/Main.load_level_four()

func _on_mario_camera_stop() -> void:
	camera_stop.emit()


func _on_mario_camera_go() -> void:
	camera_go.emit()

func _on_main_start_l_1() -> void:
	#$AudioStreamPlayer2.play()
	pass

func _on_mario_start_playing_regular_music() -> void:
	#$AudioStreamPlayer2.play()
	pass
