extends CharacterBody2D
signal start_game
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start_game") and visible:
		visible = false
		
		start_game.emit()

func _on_level_one_game_over_l_1() -> void:
	visible = true
	Score.score = 0
	PowerupStatus.powerup_status = 0
	MarioLifeLeft.lifeleft = 1
