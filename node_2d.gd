extends Node2D
signal start_timer
var game_start_scene = preload("res://game_start.tscn")
var game_over_scene = preload("res://game_over_screen.tscn")
var screen_shown = false
var is_just_opened = true
var started_gos = false
var can_show_gs = true
@onready var level_container = $SubViewportContainer/SubViewport
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if MarioLives.lives == 0 and not screen_shown and not is_just_opened and not started_gos and GameStatus.ready_for_game_over:
		started_gos = true
		can_show_gs = false
		var game_over_screen = game_over_scene.instantiate()
		add_child(game_over_screen)
		$AudioStreamPlayer.play()
		$HUD.show()
		$HUD/GameTime/Timer.stop()
		await get_tree().create_timer(3.77).timeout
		game_over_screen.queue_free()
		started_gos = false
		can_show_gs = true
		
	if MarioLives.lives == 0 and not screen_shown and can_show_gs and GameStatus.ready_for_game_over: 
		GameStatus.ready_for_game_over = false
		$HUD.hide()
		Score.score = 0
		CoinCount.coin_count = 0
		PowerupStatus.powerup_status = 0 
		GameStatus.mario_invincible = false
		var game_start_screen = game_start_scene.instantiate()
		add_child(game_start_screen)
		game_start_screen.start_game.connect(_on_start_game)
		screen_shown = true
		is_just_opened = false

func _on_level_one_show_underground_room_1() -> void:
	$UndergroundRoom.show()
	$UndergroundRoom/Mario.call_deferred("set_physics_process", true)
	
func _on_start_game():
	$HUD.show()
	MarioLives.lives = 3
	World.world = 1
	Stage.stage = 1
	#var level_one_scene = load("res://level_one.tscn")
	#var level_two_scene = load("res://level_two.tscn")
	var level_three_scene = load("res://level_three.tscn")
	load_level(level_three_scene)
	GameStatus.one_up_gettable = true
	screen_shown = false
	

var current_level = null
var additional_level = null
func load_level(scene):
	if current_level != null:
		current_level.queue_free()
	current_level = scene.instantiate()
	level_container.call_deferred("add_child",current_level)
	
	
	start_timer.emit()
func load_level_addition(scene):
	print('loading level one underground')
	if not current_level == null:
		current_level.hide()
		level_container.remove_child(current_level)
	if not additional_level == null:
		additional_level.queue_free()
	additional_level = scene.instantiate()
	level_container.call_deferred("add_child", additional_level)
func exit_level_addition():
	print('exiting level one underground')
	if not additional_level == null:
		additional_level.queue_free()
	level_container.call_deferred("add_child", current_level)
	
func exit_level() -> void:
	if not current_level == null:
		current_level.queue_free()		

func reload_level_one() -> void:
	var level_one_scene = load("res://level_one.tscn")
	load_level(level_one_scene)
func reload_level_two() -> void:
	var level_two_scene = load("res://level_two.tscn")
	load_level(level_two_scene)
func load_world_one_stage_two() -> void:
	GameStatus.one_up_gettable = true
	var level_two_scene = load("res://level_two.tscn")
	load_level(level_two_scene)
func load_flagpole_and_castle() -> void:
	var flagpole_and_castle_scene = load("res://flagpole_and_castle.tscn")
	if current_level != null:
		current_level.queue_free()
	current_level = flagpole_and_castle_scene.instantiate()
	level_container.call_deferred("add_child",current_level)
func load_level_one_underground() -> void:
	var level_one_underground_scene = load("res://underground_room.tscn")
	load_level_addition(level_one_underground_scene)
func load_level_three() -> void:
	var level_three_scene = load("res://level_three.tscn")
	load_level(level_three_scene)
func _on_camera_2d_stop_level_one() -> void:
	pass # Replace with function body.
