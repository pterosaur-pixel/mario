extends Label
signal done_displaying
func _ready() -> void:
	visible = false
func _process(delta: float) -> void:
	pass


func _on_area_2d_kill_body_entered(body: Node2D) -> void:
	#global_position.x = get_parent().global_position.x
	visible = true
	for i in range(0, 5):
		global_position.y -= 3
		await get_tree().create_timer(0.05).timeout
	done_displaying.emit()
	
	queue_free()
