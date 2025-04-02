extends CharacterBody2D
@export var type_of_platform = 0
var x = false
var direction = 1
var move_counter = 0
func _ready() -> void:
	if type_of_platform == 0:
		velocity.y = 32
	elif type_of_platform == 1:
		velocity.y = -32
	elif type_of_platform == 2:
		velocity.x = 32
	elif type_of_platform == 3:
		velocity.x = -32
func _physics_process(delta: float) -> void:
	if x:
		if type_of_platform == 0:
			velocity.y = 32
		elif type_of_platform == 1:
			velocity.y = -32
		elif type_of_platform == 2:
			velocity.y = 0
			velocity.x = direction * 32
			move_counter += 1 
		elif type_of_platform == 3:
			velocity.y = 0
			velocity.x = direction * -32
			move_counter += 1
		if move_counter > 90:
			direction = -direction
			move_counter = 0
			
		move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if global_position.y > 100 and type_of_platform == 0:
		global_position.y = -16
	if global_position.y < 10 and type_of_platform == 1:
		global_position.y = 250

func _on_visible_on_screen_notifier_2d_2_screen_entered() -> void:
	x = true
