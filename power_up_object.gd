extends CharacterBody2D
var current_powerup = 1
func _process(_delta: float) -> void:
	if current_powerup == 0:
		$AnimationPlayer.play("mushroom")
	if current_powerup == 1:
		$AnimationPlayer.play("flower") 
