extends CharacterBody2D
signal mushroom_killed_mario
signal mario_should_jump
signal mario_invincible
signal label_show()
var gravity = 1250
var direction
var floor_coor
var mario_can_kill = true
var can_kill_mario = true
var stomped = 0
var done = false
@export var enemy = 0
@onready var cur_y = global_position.y 
@onready var ap = $Sprite2D/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShellCollider/CollisionShape2D.call_deferred("set_disabled", true)
	$TurtleWallCollider.call_deferred("set_disabled", true)
	$ShellWallCollider.call_deferred("set_disabled", true)
	if enemy == 1:
		$Sprite2D/AnimationPlayer.play("turtle")
		$Sprite2D.flip_h = true
		$WallCollider.call_deferred("set_disabled", true)
		$MushroomCollider/CollisionShape2D.call_deferred("set_disabled", true)
		$TurtleWallCollider.call_deferred("set_disabled", false)
	else:
		$TurtleWallCollider.call_deferred("set_disabled", true)
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
		
	
	move_and_slide()
	
	#var x = get_slide_collision_count()
	if velocity == Vector2(0, 0):
		if enemy == 1:
			$Sprite2D.flip_h = not $Sprite2D.flip_h
			global_position.x += -direction * 10
			print($Sprite2D.flip_h)
		if stomped == 1:
			velocity.x = -direction * 100
		else:
			velocity.x = -direction * 35
		if direction == -1:
			direction = 1
		else:
			direction = -1
	
	cur_y = global_position.y
	
		
func _on_area_2d_body_entered(_body: Node2D) -> void:
	set_physics_process(true)
	


func _on_area_2d_kill_body_entered(body: Node2D) -> void:
	if mario_can_kill:
		if enemy == 1:
			print("...turtle")
			if stomped == 0:
				print("TTTTUUUUUUUURRTLE")
				$AudioStreamPlayer.play(0.05)
				print(Score.score)
				ap.play("turtle-squashed")
				global_position.y = floor_coor + 6
				print("turtle squished")
				velocity.x = 0
				set_physics_process(false)
				mario_should_jump.emit()
				stomped = 1
				await get_tree().create_timer(0.25).timeout
				$ShellCollider/CollisionShape2D.call_deferred("set_disabled", false)
		if enemy == 1 and stomped == 1 and not done:
			$AudioStreamPlayer.play(0.05)
			label_show.emit()
			$MushroomKilledScoreLabel.text = str(500)
			Score.score += 500
			if MarioGlobalPosition.mario_global_position_x > global_position.x:
				velocity.x = -100
			else:
				velocity.x = 100
			$ShellWallCollider.call_deferred("set_disabled", false)
			$TurtleWallCollider.call_deferred("set_disabled", true)
			mario_can_kill = false
			mario_should_jump.emit()
			set_physics_process(true)
			done = true
			
			
		else:
			#if 'mushroom' in body.name:
				
			#else:
				$AudioStreamPlayer.play(0.05)
				label_show.emit()
				Score.score += 200
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
	
func _on_area_2d_kill_area_entered(area: Area2D) -> void:
	if area.name == "ShellCollider" and not stomped == 1:
		print("dead by turtle")
		twirly_dead()
	


func _on_area_2d_danger_zone_body_entered(_body: Node2D) -> void:
	if can_kill_mario:
		can_kill_mario = false
		set_physics_process(false)
		#$Area2DKill/MarioKillCollider.set_disabled(true)
		#$Area2DDangerZone/CollisionShape2D.set_disabled(true)
		mario_can_kill = false
		$Area2DKill/MarioKillCollider.call_deferred("set_disabled", true)
		$Area2DDangerZone/CollisionShape2D.call_deferred("set_disabled", true)
		
		#MarioLifeLeft.lifeleft -= 1
		
		
		
		#print(MarioLifeLeft.lifeleft)
		if PowerupStatus.powerup_status == 0:
			MarioLives.lives -= 1
			print('dead mario')
			$Area2DKill.queue_free()
			$Area2DDangerZone.queue_free()
			mushroom_killed_mario.emit()
			
		else:
			PowerupStatus.powerup_status -= 1
			mario_invincible.emit()
			set_physics_process(true)
			$Area2DKill/MarioKillCollider.call_deferred("set_disabled", false)
			$Area2DDangerZone/CollisionShape2D.call_deferred("set_disabled", false)
		await get_tree().create_timer(1).timeout
		mario_can_kill = true
		can_kill_mario = true

	
func _on_level_one_game_over_l_1() -> void:
	
	print('gmovr')


func _on_mushroom_killed_score_label_done_displaying() -> void:
	if enemy == 0:
		hide()
		queue_free()

func _on_mushroom_collider_area_entered(area: Area2D) -> void:
	if not area.name == "MushroomCollider":
		print(area.name)
		print('dead mushroom by the means of a brick up the rear')
		twirly_dead()
		
		
		
	


func _on_fireball_kill_collider_body_entered(body: Node2D) -> void:
	print('FIREBALLED')
	twirly_dead()
	
func twirly_dead() -> void:

	set_physics_process(false)
	can_kill_mario = false
	mario_can_kill = false
	$ShellWallCollider.call_deferred("set_disabled", true)
	$TurtleWallCollider.call_deferred("set_disabled", true)
	$Area2DKill/MarioKillCollider.call_deferred("set_disabled", true)
	$Area2DDangerZone/CollisionShape2D.call_deferred("set_disabled", true)
	$WallCollider.call_deferred("set_disabled", true)
	$MushroomCollider/CollisionShape2D.call_deferred("set_disabled", true)
	velocity.y = -150
	set_z_index(5)
	for i in range(0, 10):
		rotation += 18
		move_and_slide()
		await get_tree().create_timer(0.05).timeout
	velocity.y = 400
	for i in range(0, 20):
		move_and_slide()
		await get_tree().create_timer(0.05).timeout
	Score.score += 100
	queue_free()
