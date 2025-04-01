extends CharacterBody2D

func _ready() -> void:
	if PowerupStatus.powerup_status == 0:
		$AnimationPlayer.play("mario-little-idle")
	elif PowerupStatus.powerup_status == 1:
		$AnimationPlayer.play("mario-idle")
	elif PowerupStatus.powerup_status >= 2:
		$AnimationPlayer.play("mario-powerup-idle")
	for i in range(0, 20):
		global_position.y -= 2
		await get_tree().create_timer(0.033).timeout
