extends CharacterBody2D
var bumping = 0
var bump = false
var can_be_bounced = false
func _ready() -> void:
	$MushroomArea/CollisionShape2D.set_disabled(true)
	if GameStatus.theme == 'overworld':
		$Sprite2D.show()
		$AnimationPlayer.play("brick")
	elif GameStatus.theme == 'underground':
		$Sprite2D4.show()
		$AnimationPlayer4.play("brick-underground")

func _process(_delta: float) -> void:
	
	if bumping == 1 and bump:
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled", false)
		$AudioStreamPlayer2.play(0.02)
		if GameStatus.theme == 'overworld':
			print('hitting an overworld brick')
			$AnimationPlayer2.play("coin_bumper_bounce")
		if GameStatus.theme == 'underground':
			print('hitting an underground brick')
			$AnimationPlayer2.play("brick-bounce-underground")
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
		if GameStatus.theme == 'overworld':
			$AnimationPlayer2.play("new_animation")
		elif GameStatus.theme == 'underground':
			$AnimationPlayer2.play("new_animation_2")
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
	if GameStatus.theme == 'overworld':
		$Sprite2D.hide()
	elif GameStatus.theme == 'underground':
		$Sprite2D4.hide()
	$Sprite2D2.show()
	if GameStatus.theme == 'overworld':
		$AnimationPlayer2.play("coin_bumper_bounce")
	if GameStatus.theme == 'underground':
		$AnimationPlayer2.play("brick-bounce-underground")
	$AudioStreamPlayer2.play(0.02)
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled", false)
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
	await get_tree().create_timer(6).timeout
	bumping = 2
	
func _on_area_2d_bump() -> void:
	bump = true
	
	
func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	if anim_name == "coin_bumper_bounce":
		print('done!!!')
		set_process(true)
	if anim_name == "brick-bounce-underground":
		print('done!!!')
		set_process(true)
		
