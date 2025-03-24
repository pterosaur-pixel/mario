extends CharacterBody2D
func _ready() -> void:
	$AnimationPlayer.play("brick-questiion-mark")
	set_physics_process(false)
var powerup = preload("res://power_up_object.tscn")
var Powerup
var direction = 1

func _on_area_2d_mushroom_hit() -> void:
	set_process(false)
	$AnimationPlayer.stop()
	$Sprite2D.hide()
	$AnimationPlayer2.play("question-brick-bounce")
	
	set_z_index(1)
	Powerup = powerup.instantiate()
	add_child(Powerup)
	
	Powerup.global_position = global_position
	for i in range(0, 8):
		Powerup.global_position.y = Powerup.global_position.y - 1.5
		await get_tree().create_timer(0.06).timeout
	Powerup.velocity.x = 35
	Powerup.set_z_index(0)
	print(Powerup.get_z_index(), get_z_index())
	print(global_position)
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	$AnimationPlayer.play("brick-questiion-mark")
	if Powerup.current_powerup == 0:
		if not Powerup.is_on_floor():
			Powerup.velocity.y += 1250 * delta
		elif Powerup.velocity.x == 0:
			direction = -direction
			Powerup.velocity.x = direction * 35
	
		Powerup.move_and_slide()
