extends CharacterBody2D

func _ready() -> void:
	hide()
	set_physics_process(false)
	$AnimationPlayer.play("brick-questiion-mark")
	$MushroomArea/CollisionShape2D.set_disabled(true)
var powerup_scene = preload("res://power_up_object.tscn")
var powerup
var direction = 1

	
func _on_area_2d_mushroom_hit() -> void:
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled",false)
	$AnimationPlayer.stop()
	show()
	$Sprite2D.hide()
	
	$Sprite2D2.show()
	$AnimationPlayer2.play("new_animation")
	await get_tree().create_timer(0.25).timeout
	$AudioStreamPlayer3.play()
	await get_tree().create_timer(0.25).timeout
	$MushroomArea/CollisionShape2D.call_deferred("set_disabled",true)
	
func _on_animation_player_2_animation_finished(_anim_name: StringName) -> void:
	
	set_z_index(1)
	powerup = powerup_scene.instantiate()
	powerup.type_of_powerup = 2
	powerup.global_position.x = global_position.x
	powerup.global_position.y = global_position.y - 12
	add_sibling(powerup)
	powerup.velocity.x = 35

func _on_mushroom_area_body_entered(_body: Node2D) -> void:
	$MushroomArea/CollisionShape2D.set_disabled(true)
	print('mushroom died on powerup brick')
