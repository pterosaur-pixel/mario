extends CharacterBody2D


func _on_level_one_show_intermission_screen() -> void:
	show()
	await get_tree().create_timer(2).timeout
	hide()
