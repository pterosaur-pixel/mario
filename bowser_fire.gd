extends CharacterBody2D
var x
func _ready() -> void:
	velocity.x = -50
	$AnimationPlayer.play("fire")
	global_position.x -= 140
	x = global_position.x - 200
	global_position.y += randf_range(-20, 10)
	
	
func _process(delta: float) -> void:
	if global_position.x > x:
		move_and_slide()
	else:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if PowerupStatus.powerup_status == 0:
		GameStatus.fire_killed_mario = true
		MarioLives.lives -= 1
		queue_free()	
	else:
		PowerupStatus.powerup_status = 0
		GameStatus.mario_invincible_bowser = true
			
			
	
