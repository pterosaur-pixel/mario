extends Area2D
signal mushroom1_hit
var first_hit = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(Body: CharacterBody2D) -> void:
	print('Well, hit!')
	if first_hit:
		
		print('first hit')
		mushroom1_hit.emit()
		first_hit = false
	
