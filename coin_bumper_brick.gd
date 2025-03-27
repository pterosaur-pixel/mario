extends CharacterBody2D
var bumping = 0
var bump = false
var can_be_bounced = false
func _ready() -> void:
	$MushroomArea/CollisionShape2D.set_disabled(true)
	$AnimationPlayer.play("brick")

func _process(delta: float) -> void:
	
	if bumping == 1 and bump:
		print('bumping')
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled", false)
		$AudioStreamPlayer2.play(0.02)
		$AnimationPlayer2.play("coin_bumper_bounce")
		$Sprite2D3.show()
		$AnimationPlayer3.play("coin_2")
		CoinCount.coin_count += 1
		$AudioStreamPlayer.play(0.05)
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled", true)
		Score.score += 200
		bump = false
		set_process(false)
		#can_be_bounced = false
	elif bumping == 2 and bump:
		$AudioStreamPlayer2.play(0.02)
		$AnimationPlayer2.play("new_animation")
		$Sprite2D3.show()
		$AnimationPlayer3.play("coin_2")
		CoinCount.coin_count += 1
		$AudioStreamPlayer.play(0.05)
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled", true)
		Score.score += 200
		bump = false
		set_process(false)
		return
	
func _on_animation_player_3_animation_finished(_anim_name: StringName) -> void:
	$Sprite2D3.hide()
	#pass

func _on_area_2d_mushroom_hit() -> void:
	$AnimationPlayer.stop()
	$Sprite2D.hide()
	$Sprite2D2.show()
	print('bumping')
	$AudioStreamPlayer2.play(0.02)
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled", false)
	$AnimationPlayer2.play("coin_bumper_bounce")
	$Sprite2D3.show()
	$AudioStreamPlayer.play(0.05)
	$AnimationPlayer3.play("coin_2")
	CoinCount.coin_count += 1
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled", true)
	Score.score += 200
	bump = false
	set_process(false)
	
	
func _on_area_2d_start_bumping() -> void:
	#can_be_bounced = true
	#pass
	bumping = 1
	await get_tree().create_timer(3).timeout
	bumping = 2
	
func _on_area_2d_bump() -> void:
	bump = true
	
	
func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	if anim_name == "coin_bumper_bounce":
		print('done!!!')
		set_process(true)
		
