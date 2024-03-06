extends Node3D

var BallBlue = preload("res://courses/scenes/ball_blue.tscn")

func _ready() -> void:
	var ball = BallBlue.instantiate()
	add_child(ball)
