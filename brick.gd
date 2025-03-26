extends CharacterBody2D

func _ready() -> void:
	set_physics_process(false)
	$AnimationPlayer.play("brick")
	$MushroomArea/CollisionShape2D.set_disabled(true)

func _on_mushroom_area_body_entered(_body: Node2D) -> void:
	$MushroomArea/CollisionShape2D.set_disabled(true)
	print('mushroom died on powerup brick')

func _on_mario_bump_area_hit() -> void:
	pass


func _on_mario_bump_area_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("brick_bounce")
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled",false)
	
	await get_tree().create_timer(0.5).timeout
	#await get_tree().create_timer(0.25).timeout
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled",true)
