extends Node2D

#await get_tree().create_timer(1.0).timeout

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass
	
func _on_level_one_grow_mushroom_1() -> void:
	print('growing mushroom')


func _on_mario_game_over() -> void:
	
	print('gameover')


func _on_level_one_show_underground_room_1() -> void:
	$UndergroundRoom.show()
	$UndergroundRoom/Mario.call_deferred("set_physics_process", true)
