extends CharacterBody2D
var broken_brick_scene = preload("res://broken_brick.tscn")
func _ready() -> void:
	set_physics_process(false)
	if GameStatus.theme == 'overworld':
		$AnimationPlayer.play("brick")
	if GameStatus.theme == "underground":
		$AnimationPlayer.play("brick-underground")
	$MushroomArea/CollisionShape2D.set_disabled(true)

func _on_mushroom_area_body_entered(_body: Node2D) -> void:
	$MushroomArea/CollisionShape2D.set_disabled(true)
	print('mushroom died on powerup brick')

func _on_mario_bump_area_hit() -> void:
	pass


func _on_mario_bump_area_body_entered(_body: Node2D) -> void:
	if PowerupStatus.powerup_status == 0:
		if GameStatus.theme == 'overworld':
			$AnimationPlayer.play("brick_bounce")
		if GameStatus.theme == "underground":
			$AnimationPlayer.play("brick_bounce_underground")
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled",false)
		
		await get_tree().create_timer(0.5).timeout
	#await get_tree().create_timer(0.25).timeout
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled",true)
	elif PowerupStatus.powerup_status <= 2:
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled",false)
		var broken_brick_1 = broken_brick_scene.instantiate()
		var broken_brick_2 = broken_brick_scene.instantiate()
		var broken_brick_3 = broken_brick_scene.instantiate()
		var broken_brick_4 = broken_brick_scene.instantiate()
		add_child(broken_brick_1)
		add_child(broken_brick_2)
		add_child(broken_brick_3)
		add_child(broken_brick_4)
		broken_brick_1.velocity = Vector2(-50, -300)
		broken_brick_2.velocity = Vector2(50, -300)
		broken_brick_3.velocity = Vector2(-50, -200)
		broken_brick_4.velocity = Vector2(50, -200)
		Score.score += 50
		$Sprite2D.hide()
		$MarioBumpArea/CollisionShape2D.call_deferred("set_disabled", true)
		$WholeBrick.call_deferred("set_disabled", true)
		await get_tree().create_timer(0.5).timeout
		$MushroomArea/CollisionShape2D.call_deferred("set_disabled", true)
