extends CharacterBody2D
@export var rotation_type = 0
@export var arm_length = 0
func _ready() -> void:
	if arm_length == 0:
		$Sprite2D11.queue_free()
		$Sprite2D10.queue_free()
		$Sprite2D9.queue_free()
		$CollisionShape2D.set_disabled(true)
		$CollisionShape2D2.set_disabled(false)
	else:
		$CollisionShape2D2.set_disabled(true)
		$CollisionShape2D.set_disabled(false)
func _process(delta: float) -> void:
	if rotation_type == 0:
		rotation += 0.05
	elif rotation_type == 1:
		rotation -= 0.05
