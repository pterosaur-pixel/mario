extends CharacterBody2D

func _ready() -> void:
	$AnimationPlayer.play("axe")

func _on_axe_area_2d_body_entered(body: Node2D) -> void:
	GameStatus.beat_world_one = true
	#get_tree().paused = true
	queue_free()
