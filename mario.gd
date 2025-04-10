extends CharacterBody2D
signal game_over
signal camera_stop
signal mario_in_castle
signal start_playing_regular_music
const SPEED = 82.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1250
var can_change_colliders = true
var direction2 = 1
var fireball_scene = preload("res://fireball.tscn")
var is_fire_ball
var screen_size
var crouch = false
var invincible = 0
var first_trigger = true
var input_allowed = true
var started_world_over = false
@onready var  last_pu = PowerupStatus.powerup_status

#var last_pu = PowerupStatus.powerup_status
func _ready() -> void:
	set_z_index(-1)
	set_physics_process(false)
	screen_size = get_viewport_rect().size
	MarioGlobalPosition.mario_global_position_x = global_position.x
	$CollisionPolygon2D.call_deferred("set_disabled", false)
	$CollisionPolygon2D2.call_deferred("set_disabled", true)	
	$CollisionPolygon2D3.call_deferred("set_disabled", true)	
	if PowerupStatus.powerup_status == 0:
		$AnimationPlayer.play("mario-little-idle")
		$CollisionPolygon2D.set_disabled(true)
	elif PowerupStatus.powerup_status == 1:
		$AnimationPlayer.play("mario-idle")
		$CollisionPolygon2D.set_disabled(true)
	elif PowerupStatus.powerup_status >= 2:
		$AnimationPlayer.play("mario-powerup-idle")
		$CollisionPolygon2D.set_disabled(true)
	
	for i in range(0, 10):
		global_position.y -= 2
		await get_tree().create_timer(0.033).timeout
	$CollisionPolygon2D.set_disabled(false)
	$CollisionPolygon2D.set_disabled(false)
	$CollisionPolygon2D.set_disabled(false)
	set_physics_process(true)
	set_z_index(0)
func _physics_process(delta: float) -> void:
	if GameStatus.beat_world_one:
		#started_world_over = true
		if PowerupStatus.powerup_status == 0:
			mario_end_world_animation("little-")
		if PowerupStatus.powerup_status == 1:
			mario_end_world_animation("")
		if PowerupStatus.powerup_status >= 2:
			mario_end_world_animation("powerup-")
				
	if GameStatus.fire_killed_mario:
		GameStatus.fire_killed_mario = false
		mario_dead_mushroom()
	if GameStatus.mario_invincible_bowser:
		make_mario_invincible()
		GameStatus.mario_invincible_bowser = false
		
	MarioGlobalPosition.mario_global_position_x = global_position.x
	$Sprite2D.show()
	if not last_pu == PowerupStatus.powerup_status:
		last_pu = PowerupStatus.powerup_status
		if last_pu <= 0 and can_change_colliders:
			$CollisionPolygon2D.call_deferred("set_disabled", false)
			$CollisionPolygon2D2.call_deferred("set_disabled", true)
			$CollisionPolygon2D3.call_deferred("set_disabled", true)
		if last_pu == 1 and can_change_colliders:
			print("mario-animating")
			$CollisionPolygon2D.call_deferred("set_disabled", true)
			$CollisionPolygon2D2.call_deferred("set_disabled", false)
			global_position.y = global_position.y - 5
			get_big()
			return
			
		elif last_pu > 1:
			get_flower()
			return
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if Input.is_action_just_pressed("move_up") and is_on_floor() and input_allowed:
		$AudioStreamPlayer3.play(0.1)
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("move_down") and last_pu >= 1 and can_change_colliders and input_allowed:
		crouch = true
		$CollisionPolygon2D2.call_deferred("set_disabled", true)
		$CollisionPolygon2D3.call_deferred("set_disabled", false)
	elif last_pu >= 1 and can_change_colliders:
		crouch = false
		$CollisionPolygon2D2.call_deferred("set_disabled", false)
		$CollisionPolygon2D3.call_deferred("set_disabled", true)
	elif can_change_colliders:
		$CollisionPolygon2D.call_deferred("set_disabled", false)
		$CollisionPolygon2D2.call_deferred("set_disabled", true)
		
	if Input.is_action_just_pressed("shoot_fireball") and PowerupStatus.powerup_status >= 2 and input_allowed:
		if FireballsOnScreen.fireballs_on_screen <= 2:
			var fireball = fireball_scene.instantiate()
			add_child(fireball)
			fireball.global_position.x = global_position.x + direction2 * 30
			fireball.global_position.y = global_position.y
			fireball.velocity.x = direction2 * 200
		
	
		
	var direction := Input.get_axis("move_left", "move_right")
	if not input_allowed:
		direction = 0
	if not direction2 == direction:
		if not direction == 0:
			direction2 = direction
	
	if direction and is_on_floor():
		#$Camera2D.global_position.y = $Camera2D.y
		velocity.x = direction * SPEED
		if direction < 0:
			$Sprite2D.flip_h = true
		if direction > 0:
			$Sprite2D.flip_h = false
		if Input.is_action_pressed("extra_speed") and input_allowed:
			velocity.x = direction * SPEED * 2
		
	elif direction:
		if velocity.x == 0:
			velocity.x = (direction * SPEED)/8
		
		if direction < 0:
			$Sprite2D.flip_h = true
		if direction > 0:
			$Sprite2D.flip_h = false
				
	elif is_on_floor():	
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	if invincible == 1:
		$Sprite2D.hide()
		invincible = 2
	elif invincible == 2:
		$Sprite2D.show()
		invincible = 1
	if GameStatus.mario_invincible and first_trigger:
		$AudioStreamPlayer4.play()
		first_trigger = false
		invincible = 1
		await get_tree().create_timer(10).timeout
		invincible = 0
		$Sprite2D.show()
		first_trigger = true
		$AudioStreamPlayer4.stop()
		GameStatus.mario_invincible = false
		start_playing_regular_music.emit()
	update_animations(direction, last_pu)
	
	
	
func update_animations(direction, last):
	if direction and is_on_floor() and last == 0 and input_allowed:
		$AnimationPlayer.play("mario-little-running")
	elif not is_on_floor() and last == 0 and input_allowed:
		$AnimationPlayer.play("mario-little-jump")	
	elif last == 0 and input_allowed:
		$AnimationPlayer.play("mario-little-idle")
	elif crouch and last == 1 and input_allowed:
		$AnimationPlayer.play("mario-crouch")
	elif direction and is_on_floor() and last == 1 and input_allowed:
		$AnimationPlayer.play("mario-running")
	elif not is_on_floor() and last == 1 and input_allowed:
		$AnimationPlayer.play("mario-jump")
	elif last == 1 and input_allowed:
		$AnimationPlayer.play("mario-idle")
	elif crouch and last >= 2 and input_allowed:
		$AnimationPlayer.play("mario-powerup-crouch")
	elif direction and is_on_floor() and last >= 2 and input_allowed:
		$AnimationPlayer.play("mario-powerup-running")
	elif not is_on_floor() and last >= 2 and input_allowed:
		$AnimationPlayer.play("mario-powerup-jump")
	elif last >= 2 and input_allowed:
		$AnimationPlayer.play("mario-powerup-idle")

func _on_level_one_fall_collider_entered() -> void:
	print('dead marioooooooooooo')
	game_over.emit()
	velocity = Vector2(0, 0)
	set_physics_process(false)
	#move_and_slide()

	
func _on_level_one_mushroom_killed_mario_l_1() -> void:
	mario_dead_mushroom()
func _on_audio_stream_player_finished() -> void:
	print('dead mario')
	game_over.emit()
	velocity = Vector2(0, 0)
	set_physics_process(false)
	

func _on_level_one_mario_should_jumpl_1() -> void:
	velocity.y = -150
	
func _on_level_one_start_game() -> void:
	set_physics_process(true)
	
func get_big() -> void:
	set_physics_process(false)
	for i in range(0, 10):
		$AnimationPlayer.play("mario-little-big")
		await get_tree().create_timer(0.1).timeout
	print('playing animation')
	set_physics_process(true)
	

func get_flower() -> void:
	set_physics_process(false)
	for i in range(0, 10):
		$AnimationPlayer.play("mario-big-shooter")
		await get_tree().create_timer(0.1).timeout
	print('playing animation')
	set_physics_process(true)

	


func _on_mushroom_mario_invincible() -> void:
	$AudioStreamPlayer2.play()
	
	
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, false)
	
	#$CollisionPolygon2D2.call_deferred("set_disabled", true)
	#$CollisionPolygon2D3.call_deferred("set_disabled", true)
	invincible = 1
	await get_tree().create_timer(3).timeout
	invincible = 0
	show()
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)
	


func _on_flagpole_flag_mario_grabbed_pole() -> void:
	camera_stop.emit()
	set_z_index(2)
	set_physics_process(false)
	if last_pu == 0:
		end_animation("little-")
	if last_pu == 1:
		end_animation("")
	if last_pu >= 2:
		end_animation("powerup-")
		
func end_animation(size):
	$AnimationPlayer.play("mario-"+size + "flagpole")
	global_position.x += 2
	velocity.y = 200
	velocity.x = 0
	await get_tree().create_timer(0.1).timeout
	$AnimationPlayer.pause()
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("mario-"+size+"flagpole")
	while not is_on_floor():
		move_and_slide()
		await get_tree().create_timer(0.033).timeout
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("mario-"+size+"idle")
	global_position.x += 30
	velocity.y = 200
	for i in range(0, 20):
		move_and_slide()
		await get_tree().create_timer(0.033).timeout
	$AnimationPlayer.play("mario-"+size+"running")
	for i in range(0, 46):
		global_position.x += 3
		move_and_slide()
		await get_tree().create_timer(0.033).timeout
	$AnimationPlayer.play("mario-"+size+"idle")
	hide()
	mario_in_castle.emit()
		
		


func _on_level_two_fall_collider_entered() -> void:
	print('dead marioooooooooooo')
	game_over.emit()
	velocity = Vector2(0, 0)
	set_physics_process(false)


func _on_level_two_mario_should_jumpl_2() -> void:
	velocity.y = -150


func _on_level_two_mushroom_killed_mario_l_2() -> void:
	mario_dead_mushroom()
	
func mario_dead_mushroom():
	velocity.x = 0
	$AudioStreamPlayer.play()
	set_physics_process(false)
	set_z_index(3)
	await get_tree().create_timer(0.033).timeout
	$AnimationPlayer.play("mario-dead")		
	$CollisionPolygon2D.call_deferred("set_disabled", true)
	$CollisionPolygon2D2.call_deferred("set_disabled", true)
	$CollisionPolygon2D3.call_deferred("set_disabled", true)	
	velocity.y = -200
	for i in range(0, 10):
		move_and_slide()
		await get_tree().create_timer(0.06).timeout
	velocity.y = 600
	for i in range(0, 20):
		move_and_slide()
		await get_tree().create_timer(0.06).timeout
	print('emitting game over signal from mario.')
	game_over.emit()

func _on_level_two_start_game() -> void:
	set_physics_process(true)

func _on_mushroom_mushroom_killed_mario() -> void:
	mario_dead_mushroom()
func make_mario_invincible():
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)
	set_collision_layer_value(23, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, false)
	set_collision_mask_value(23, false)
	invincible = 1
	await get_tree().create_timer(2).timeout
	invincible = 0
	$Sprite2D.show()
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, true)
	set_collision_layer_value(23, true)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)
	set_collision_mask_value(23, true)

func mario_end_world_animation(size):
	input_allowed = false
	#set_physics_process(false)
	#await get_tree().create_timer(1).timeout
	#set_physics_process(true)
	velocity.x = 40
	velocity.y = 20
	$AnimationPlayer.play("mario-"+size+"running")
	#while global_position.x < 1650:
	move_and_slide()
	await get_tree().create_timer(0.033).timeout
	if global_position.x > 1650:
		$AnimationPlayer.play("mario-"+size+"idle")
		velocity.x = 0
		started_world_over = true
	
