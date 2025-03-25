extends Node2D
signal grow_mushroom1
signal mushroom_killed_mario_l1
signal mario_should_jumpl1
signal game_over_l1
signal start_game
signal fall_collider_entered
signal camera_stop
signal camera_go

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
