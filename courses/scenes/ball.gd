extends RigidBody3D


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(linear_velocity * delta)
	if collision:
		var normal := collision.get_normal()

		print(normal)
		print(collision.get_angle())
		if normal.y != 0 and normal.y != 1:
			return

		# Keep the ball on the ground, not fall through.
		if normal.y != 0:
			linear_velocity.y = 0

		# Bounce off walls.
		if normal.x != 0 or normal.z != 0:
			var new_velocity := linear_velocity.bounce(normal)
			linear_velocity.x = new_velocity.x
			linear_velocity.z = new_velocity.z

	# Stop the ball rolling forever.
	if linear_velocity.length() < 0.03:
		linear_velocity = Vector3.ZERO
