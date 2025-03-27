extends Node2D
signal underground_room_exited

func _on_portal_to_aboveground_body_entered(body: Node2D) -> void:
	$AudioStreamPlayer.play(0.02)
	underground_room_exited.emit()
	hide()
	await get_tree().create_timer(0.7).timeout
	queue_free()
	
