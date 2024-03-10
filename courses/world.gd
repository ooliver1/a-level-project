extends Node3D

const BALL_BLUE = preload("res://courses/scenes/ball_blue.tscn")


func _ready() -> void:
	var ball: RigidBody3D = BALL_BLUE.instantiate()
	add_child(ball)
	ball.position = Vector3(0, 0.2, 1)
	await get_tree().create_timer(1).timeout
	ball.apply_central_impulse(Vector3(1.5, 0, 3))
