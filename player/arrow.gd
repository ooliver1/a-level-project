class_name Arrow
extends Node3D


@onready var inner: Node3D = $Inner


## Rotate and scale the arrow opposite to the given `position`.
func move_to(mouse_position: Vector3) -> void:
	print(mouse_position)
	var z_scale := _distance_to_z_scale(mouse_position.length())
	var x_scale := _z_scale_to_x(z_scale)
	var angle := mouse_position.signed_angle_to(-Vector3.FORWARD, Vector3.DOWN)
	print(angle)
	inner.scale.x = x_scale
	inner.scale.z = z_scale
	rotation.y = angle


## Convert a distance to an approximately appropriate scale.
func _distance_to_z_scale(distance: float) -> float:
	distance = clampf(distance, 0.15, 5)
	return 0.72 * distance + 0.9


## Map a z scale to an appropriate x scale.
func _z_scale_to_x(z_scale: float) -> float:
	return 1 + (z_scale - 3) * 0.25
