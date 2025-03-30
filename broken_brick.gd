extends CharacterBody2D
func _ready() -> void:
	if GameStatus.theme == 'overworld':
		$AnimationPlayer.play("broken-brick")
	elif GameStatus.theme == 'underground':
		$AnimationPlayer.play("brick-broken-underground")
	$AudioStreamPlayer.play()

func _process(delta: float) -> void:
	velocity.y += 1250 * delta
	move_and_slide()
