extends Node3D

const BALL_BLUE = preload("res://courses/scenes/ball_blue.tscn")


func _ready() -> void:
	var ball: Node3D = BALL_BLUE.instantiate()
	add_child(ball)
	ball.position = Vector3(0, 0.1, 0.1)
