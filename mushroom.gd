extends CharacterBody2D
signal mushroom_killed_mario
signal mario_should_jump
var gravity = 1250
var direction
var floor_coor
@onready var cur_y = global_position.y 
@onready var ap = $Sprite2D/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity.x = -35
	set_physics_process(false)
	#set_safe_margin(1)
	direction = -1 	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity * delta	
	else:
		velocity.y = 0
		floor_coor = global_position.y
		
	if cur_y > global_position.y:
		print('mario killed me by my butt!')
	move_and_slide()
	
	var x = get_slide_collision_count()
	if velocity == Vector2(0, 0):
		velocity.x = direction * 35
		if direction == -1:
			direction = 1
		else:
			direction = -1
	cur_y = global_position.y
		
func _on_area_2d_body_entered(_body: Node2D) -> void:
	set_physics_process(true)
	


func _on_area_2d_kill_body_entered(_body: Node2D) -> void:
	Score.score += 100
	print(Score.score)
	$Area2DKill.queue_free()
	$Area2DDangerZone.queue_free()
	
	ap.play("evil-mushroom-squashed")
	
	global_position.y = floor_coor + 6
	print("squished")
	velocity.x = 0
	set_physics_process(false)
	mario_should_jump.emit()
	
	await get_tree().create_timer(0.25).timeout
	
	
	


func _on_area_2d_danger_zone_body_entered(_body: Node2D) -> void:
	$Area2DKill.queue_free()
	$Area2DDangerZone.queue_free()
	mushroom_killed_mario.emit()


func _on_level_one_game_over_l_1() -> void:
	
	print('gmovr')


	


func _on_mushroom_killed_score_label_done_displaying() -> void:
	hide()
	queue_free()
