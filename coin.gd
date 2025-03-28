extends CharacterBody2D

func _ready() -> void:
	var x = randf_range(0, 0.74)
	$AnimationPlayer.play("blinking_coin")
	$AnimationPlayer.advance(x)
func _on_area_2d_body_entered(_body: Node2D) -> void:
	$AudioStreamPlayer.play(0.02)
	Score.score += 200
	CoinCount.coin_count += 1
	hide()
	await get_tree().create_timer(0.6).timeout
	queue_free()
