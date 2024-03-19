extends RigidBody3D

@export var MIN_VELOCITY: float = 0.03
@export var ELASTICITY: float = 0.9


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(linear_velocity * delta)
	if collision:
		var normal := collision.get_normal()

		# Bounce off walls.
		if normal.x != 0 or normal.z != 0:
			linear_velocity = linear_velocity.bounce(normal) * ELASTICITY

	# Stop the ball rolling forever.
	if linear_velocity.length() < MIN_VELOCITY:
		linear_velocity = Vector3.ZERO
