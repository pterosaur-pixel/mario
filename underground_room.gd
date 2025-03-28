extends Node2D
signal underground_room_exited
func _ready() -> void:
	$AudioStreamPlayer2.play()
func _on_portal_to_aboveground_body_entered(_body: Node2D) -> void:
	$AudioStreamPlayer.play(0.02)
	underground_room_exited.emit()
	$/root/Main.exit_level_addition()
	hide()
	await get_tree().create_timer(0.7).timeout
	queue_free()
	
