class_name Arrow
extends Node3D

@onready var inner: Node3D = $Inner


## Get the power.
func get_power() -> float:
	return (inner.scale.z * 2) - 1.75


## Rotate and scale the arrow opposite to the given `position`.
func move_to(mouse_position: Vector3) -> void:
	var z_scale := _distance_to_z_scale(mouse_position.length())
	var x_scale := _z_scale_to_x(z_scale)
	var angle := mouse_position.signed_angle_to(-Vector3.FORWARD, Vector3.DOWN)

	inner.scale.x = x_scale
	inner.scale.z = z_scale
	rotation.y = angle


## Convert a distance to an approximately appropriate scale.
func _distance_to_z_scale(distance: float) -> float:
	distance = clampf(distance, 0.15, 0.5)
	return 10 * distance - 0.5


## Map a z scale to an appropriate x scale.
func _z_scale_to_x(z_scale: float) -> float:
	return 1 + (z_scale - 3) * 0.25
