extends CharacterBody2D
func _ready() -> void:
	$AnimationPlayer.play("broken-brick")
	$AudioStreamPlayer.play()

func _process(delta: float) -> void:
	velocity.y += 1250 * delta
	move_and_slide()
