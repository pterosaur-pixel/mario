extends CharacterBody2D
@export var rotation_type = 0
@export var arm_length = 0
var can_kill_mario = true
signal mushroom_killed_mario
signal mario_invincible
func _ready() -> void:
	if arm_length == 0:
		$Sprite2D11.queue_free()
		$Sprite2D10.queue_free()
		$Sprite2D9.queue_free()
		$Area2D/CollisionShape2D.set_disabled(true)
		$Area2D/CollisionShape2D2.set_disabled(false)
	else:
		$Area2D/CollisionShape2D2.set_disabled(true)
		$Area2D/CollisionShape2D.set_disabled(false)

func _process(delta: float) -> void:
	if rotation_type == 0:
		rotation += 2 * delta
	elif rotation_type == 1:
		rotation -= 2 * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if can_kill_mario and not GameStatus.mario_invincible:
		can_kill_mario = false
		set_physics_process(false)
		$Area2D/CollisionShape2D.call_deferred("set_disabled", true)
		$Area2D/CollisionShape2D2.call_deferred("set_disabled", true)

		if PowerupStatus.powerup_status == 0:
			MarioLives.lives -= 1
			$Area2D/CollisionShape2D.queue_free()
			$Area2D/CollisionShape2D2.queue_free()
			mushroom_killed_mario.emit()
			
		else:
			PowerupStatus.powerup_status = 0
			mario_invincible.emit()
			set_physics_process(true)
			$Area2D/CollisionShape2D.call_deferred("set_disabled", false)
			$Area2D/CollisionShape2D2.call_deferred("set_disabled", false)
		await get_tree().create_timer(1).timeout
		can_kill_mario = true
