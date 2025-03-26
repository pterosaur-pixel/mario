extends CharacterBody2D
signal game_over
signal camera_stop
signal mario_in_castle
const SPEED = 82.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1250
var last_pu 
#var last_pu = PowerupStatus.powerup_status
func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if not last_pu == PowerupStatus.powerup_status:
	
		last_pu = PowerupStatus.powerup_status
	
		if last_pu == 0:
			$CollisionShape2DLittle.call_deferred("set_disabled", false)
			$CollisionShape2D.call_deferred("set_disabled", true)
		if last_pu == 1:
			print("mario-animating")
			$CollisionShape2DLittle.call_deferred("set_disabled", true)
			$CollisionShape2D.call_deferred("set_disabled", false)
			global_position.y = global_position.y - 5
			
			get_big()
			return
			#$AnimationPlayer.play("mario-idle")
			#await get_tree().create_timer(0.5).timeout
			
		elif last_pu > 1:
			get_flower()
			return
#			$CollisionShape2DLittle.call_deferred("set_disabled", true)
#			$CollisionShape2D.call_deferred("set_disabled", false)
		
			
	#set_platform_on_leave(PLATFORM_ON_LEAVE_DO_NOTHING)
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
		#$Camera2D.global_position.y = $Camera2D.y
		
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		$AudioStreamPlayer3.play(0.1)
		velocity.y = JUMP_VELOCITY
			
	
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction and is_on_floor():
		#$Camera2D.global_position.y = $Camera2D.y
		velocity.x = direction * SPEED
		if direction < 0:
			$Sprite2D.flip_h = true
		if direction > 0:
			$Sprite2D.flip_h = false
		if Input.is_action_pressed("extra_speed"):
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
	update_animations(direction, last_pu)
	
	
	
func update_animations(direction, last):
	if direction and is_on_floor() and last == 0:
		$AnimationPlayer.play("mario-little-running")
	elif not is_on_floor() and last == 0:
		$AnimationPlayer.play("mario-little-jump")
		
	elif last == 0:
		$AnimationPlayer.play("mario-little-idle")
	elif direction and is_on_floor() and last == 1:
		$AnimationPlayer.play("mario-running")
	elif not is_on_floor() and last == 1:
		$AnimationPlayer.play("mario-jump")
	elif last == 1:
		$AnimationPlayer.play("mario-idle")
	elif direction and is_on_floor() and last >= 2:
		$AnimationPlayer.play("mario-powerup-running")
	elif not is_on_floor() and last >= 2:
		$AnimationPlayer.play("mario-powerup-jump")
	elif last >= 2:
		$AnimationPlayer.play("mario-powerup-idle")

func _on_level_one_fall_collider_entered() -> void:
	print('dead marioooooooooooo')
	game_over.emit()
	velocity = Vector2(0, 0)
	set_physics_process(false)
	move_and_slide()

	
func _on_level_one_mushroom_killed_mario_l_1() -> void:
	$AudioStreamPlayer.play()
	set_physics_process(false)
	set_z_index(3)
	$AnimationPlayer.play("mario-dead")	
	
	$CollisionShape2D.call_deferred("set_disabled",true)
	$CollisionShape2DLittle.call_deferred("set_disabled",true)
	velocity.y = -200

	for i in range(0, 10):
		move_and_slide()
		await get_tree().create_timer(0.06).timeout
	print(velocity.y)
	velocity.y = 600
	
	for i in range(0, 20):
		move_and_slide()
		await get_tree().create_timer(0.06).timeout
func _on_audio_stream_player_finished() -> void:
	print('dead mario')
	game_over.emit()
	velocity = Vector2(0, 0)
	set_physics_process(false)
	

func _on_level_one_mario_should_jumpl_1() -> void:
	velocity.y = -150
	
func _on_level_one_start_game() -> void:
	print(velocity, 'vvvvvvvvelocity', global_position)
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
	$CollisionShape2D.call_deferred("set_disabled", true)
	$CollisionShape2DLittle.call_deferred("set_disabled", true)
	
	


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
		
		
	
