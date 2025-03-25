extends CharacterBody2D
func _ready() -> void:
	pass
#	$MushroomArea/CollisionShape2D.set_disabled(false)
func _process(_delta: float) -> void:
	$AnimationPlayer.play("brick-questiion-mark")
func _on_area_2d_mushroom_hit() -> void:
	set_process(false)
	$AnimationPlayer.stop()
	$Sprite2D.hide()
	$Sprite2D2.show()
#	$MushroomArea/CollisionShape2D.set_disabled(false)
	$AnimationPlayer2.play("new_animation")
	await get_tree().create_timer(0.25).timeout
	$Sprite2D3.show()
	$AnimationPlayer3.play("coin")
#	$MushroomArea/CollisionShape2D.set_disabled(true)
	Score.score += 200
	


func _on_animation_player_3_animation_finished(_anim_name: StringName) -> void:
	$Sprite2D3.hide()
