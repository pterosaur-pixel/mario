extends Area2D

signal mushroom_hit
signal start_bumping 
signal bump
var first_hit = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass


func _on_body_entered(_Body: CharacterBody2D) -> void:
	if first_hit:
		print('first hit')
		mushroom_hit.emit()
		start_bumping.emit()
		first_hit = false
	else:
		bump.emit()
