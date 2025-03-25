extends Label
signal done_displaying
func _ready() -> void:
	visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	visible = true
	show()
	for i in range(0, 5):
		global_position.y -= 3
		await get_tree().create_timer(0.05).timeout
	done_displaying.emit()
