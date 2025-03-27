extends Area2D
signal mario_to_underground
func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_down"):
		mario_to_underground.emit()
		set_process(false)
		
func _on_body_entered(_body: Node2D) -> void:
	set_process(true)
	
func _on_body_exited(_body: Node2D) -> void:
	set_process(false)
