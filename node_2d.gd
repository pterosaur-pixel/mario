extends Node2D
signal start_timer
var game_start_scene = preload("res://game_start.tscn")
var screen_shown = false
@onready var level_container = $SubViewportContainer/SubViewport
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if MarioLives.lives == 0 and not screen_shown:
		var game_start_screen = game_start_scene.instantiate()
		add_child(game_start_screen)
		game_start_screen.start_game.connect(_on_start_game)
		screen_shown = true

func _on_level_one_show_underground_room_1() -> void:
	$UndergroundRoom.show()
	$UndergroundRoom/Mario.call_deferred("set_physics_process", true)
	
func _on_start_game():
	MarioLives.lives = 3
	World.world = 1
	Stage.stage = 1
	var level_one_scene = load("res://level_one.tscn")
	load_level(level_one_scene)
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
	
		

func reload_level_one() -> void:
	var level_one_scene = load("res://level_one.tscn")
	load_level(level_one_scene)
func reload_level_two() -> void:
	var level_two_scene = load("res://level_two.tscn")
	load_level(level_two_scene)
func load_level_one_underground() -> void:
	var level_one_underground_scene = load("res://underground_room.tscn")
	load_level_addition(level_one_underground_scene)

func _on_camera_2d_stop_level_one() -> void:
	pass # Replace with function body.
