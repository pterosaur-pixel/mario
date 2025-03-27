extends CharacterBody2D
func _ready() -> void:
	$MushroomArea/CollisionShape2D.set_disabled(true)
func _process(_delta: float) -> void:
	$AnimationPlayer.play("brick-questiion-mark")
func _on_area_2d_mushroom_hit() -> void:
	set_process(false)
	$AnimationPlayer.stop()
	$Sprite2D.hide()
	$Sprite2D2.show()
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled", false)
	
	$AnimationPlayer2.play("new_animation")
	$AudioStreamPlayer2.play(0.02)
	await get_tree().create_timer(0.25).timeout
	$Sprite2D3.show()
	$AnimationPlayer3.play("coin")
	CoinCount.coin_count += 1
	$AudioStreamPlayer.play(0.05)
	await get_tree().create_timer(0.25).timeout
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled", true)
	Score.score += 200
	


func _on_animation_player_3_animation_finished(_anim_name: StringName) -> void:
	$Sprite2D3.hide()
