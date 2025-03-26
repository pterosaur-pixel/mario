extends CharacterBody2D
func _ready() -> void:
	FireballsOnScreen.fireballs_on_screen += 1
	$AudioStreamPlayer.play(0.02)
	$AnimationPlayer.play("fireball")
func _process(delta: float) -> void:
	move_and_slide()
	if not is_on_floor():
		velocity.y += 1250 * delta
	elif is_on_floor():
		velocity.y = -200
	if velocity.x == 0:
		await  get_tree().create_timer(0.05).timeout
		FireballsOnScreen.fireballs_on_screen -= 1
		queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	FireballsOnScreen.fireballs_on_screen -= 1
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print('done firing')
	await get_tree().create_timer(0.05).timeout
	FireballsOnScreen.fireballs_on_screen -= 1
	queue_free()
