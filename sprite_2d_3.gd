extends Sprite2D


func _on_animation_player_3_animation_started(anim_name: StringName) -> void:
	await get_tree().create_timer(0.15).timeout
	$Label.visible = true
	await get_tree().create_timer(0.25).timeout
	$Label.visible = false
