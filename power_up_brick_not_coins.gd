extends CharacterBody2D

func _ready() -> void:
	set_physics_process(false)
	$AnimationPlayer.play("brick-questiion-mark")
var powerup_scene = preload("res://power_up_object.tscn")
var powerup
var direction = 1

func _on_area_2d_mushroom_hit() -> void:
	set_physics_process(false)
	$AnimationPlayer.stop()
	$Sprite2D.hide()
	$Sprite2D2.show()
	$AnimationPlayer2.play("new_animation")
	
	

func _physics_process(delta: float) -> void:
	#$AnimationPlayer.play("brick-questiion-mark")
	pass
	
	


func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	
	set_z_index(1)
	powerup = powerup_scene.instantiate()
	powerup.global_position.x = global_position.x
	powerup.global_position.y = global_position.y - 12
	add_sibling(powerup)
	
	
	
	

	powerup.velocity.x = 35
	
	
	set_physics_process(true)
	
