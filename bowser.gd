extends CharacterBody2D

func _ready() -> void:
	$AnimationPlayer.play("bowser-walking")
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if anim_name == "bowser-walking":
		print('hi')
		$AnimationPlayer.play("bowser-walking_2")
		$Sprite2D.flip_h = true
	else:
		$AnimationPlayer.play("bowser-walking")
		$Sprite2D.flip_h = false
