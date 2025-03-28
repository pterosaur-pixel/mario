extends CharacterBody2D
signal mario_grabbed_pole
signal start_stage_clear_music
var can_grab_pole = true
func _ready() -> void:
	$AnimationPlayer.play("flag")
	set_z_index(1)
	velocity.y = 200

func _on_area_2d_5_body_entered(_body: Node2D) -> void:
	grabbed_pole(100)

func _on_area_2d_4_body_entered(_body: Node2D) -> void:
	grabbed_pole(400)

func _on_area_2d_3_body_entered(_body: Node2D) -> void:
	grabbed_pole(800)

func _on_area_2d_2_body_entered(_body: Node2D) -> void:
	grabbed_pole(2000)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	grabbed_pole(5000)
func grabbed_pole(points_given):
	if can_grab_pole:
		can_grab_pole = false
		Score.score += points_given
		mario_grabbed_pole.emit()
		await get_tree().create_timer(1.2).timeout
		$AnimationPlayer.play("moving_flag")
		$AudioStreamPlayer.play()
		$Label.text = str(points_given)
		$Label.visible = true
		for i in range(0, 75):
			$Label.global_position.y -= 2
			await get_tree().create_timer(0.033).timeout

func _on_mario_mario_in_castle() -> void:
	set_z_index(-1)
	$Label.visible = false
	#$Sprite2D.visible = false
	$Sprite2D2.global_position = Vector2(1275, 120)
	$Sprite2D2.visible = true
	$AnimationPlayer2.play("castle-flag-rising")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "moving_flag":
		start_stage_clear_music.emit()
