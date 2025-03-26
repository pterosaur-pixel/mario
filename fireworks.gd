extends CharacterBody2D
func _ready() -> void:
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("firework")
	Score.score += 500


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
