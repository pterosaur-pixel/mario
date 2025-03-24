extends CharacterBody2D
func _process(delta: float) -> void:
	$AnimationPlayer.play("brick-questiion-mark")
func _on_area_2d_mushroom_hit() -> void:
	set_process(false)
	$AnimationPlayer.stop()
	$Sprite2D.hide()
	$Sprite2D2.show()
	$AnimationPlayer2.play("new_animation")
	
func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
