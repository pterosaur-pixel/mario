extends Node2D
func _ready() -> void:
	visible = false

func _on_game_start_start_game() -> void:
	visible = true
	
