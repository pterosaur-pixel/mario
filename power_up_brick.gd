extends CharacterBody2D
signal collider_should_bounce
func _process(delta: float) -> void:
	$AnimationPlayer.play("brick-questiion-mark")
func _on_area_2d_mushroom_hit() -> void:
	set_process(false)
	$AnimationPlayer.stop()
	$Sprite2D.hide()
	$AnimationPlayer2.play("question-brick-bounce")
	collider_should_bounce.emit()
	
	
	
	
