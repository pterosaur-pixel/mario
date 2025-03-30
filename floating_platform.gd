extends CharacterBody2D
@export var type_of_platform = 0
func _ready() -> void:
	if type_of_platform == 0:
		velocity.y = 32
	elif type_of_platform == 1:
		velocity.y = -32
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if global_position.y > 100 and type_of_platform == 0:
		global_position.y = -16
	if global_position.y < 10 and type_of_platform == 1:
		global_position.y = 250
