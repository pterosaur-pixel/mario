extends Label
signal done_displaying
func _ready() -> void:
	visible = false
func _process(_delta: float) -> void:
	pass


	


func _on_mushroom_label_show() -> void:
	visible = true
	for i in range(0, 5):
		global_position.y -= 3
		await get_tree().create_timer(0.05).timeout
	done_displaying.emit()
	
	queue_free()
