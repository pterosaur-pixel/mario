extends SubViewportContainer
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start_game") and not visible:
		visible = true
