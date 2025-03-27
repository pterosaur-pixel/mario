extends Area2D
signal mario_to_underground
var x = false
func _ready() -> void:
	set_process(false)
func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_down") and not x:
		x = true
		$AudioStreamPlayer.play(0.02)
		await get_tree().create_timer(0.7).timeout
		queue_free()
		mario_to_underground.emit()
		set_process(false)
		
func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	set_process(true)
	
#func _on_body_exited(_body: Node2D) -> void:
	
