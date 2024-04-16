extends Node

enum Action { PIVOTING, DRAGGING, NONE }

## Distance from ball to consider a gesture a drag.
@export var DRAG_THRESHOLD: float = 0.2

var action: Action = Action.NONE
var mouse_sensitivity: int = 1

@onready var ray_cast: RayCast3D = %RayCast
@onready var camera: Camera3D = %Camera
@onready var arrow: Arrow = %Arrow
@onready var camera_spring: SpringArm3D = %CameraSpring
@onready var ball: RigidBody3D = %Ball
@onready var controls: Node3D = $Controls


func _ready() -> void:
	ball.position = Vector3(9.25, 2, 7.25)
	#await get_tree().create_timer(1).timeout
	#ball.apply_impulse(Vector3(5, 0, 3))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		# Pivot camera on right click drag.
		if mouse_event.button_index == MOUSE_BUTTON_RIGHT:
			if mouse_event.pressed:
				if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
					action = Action.PIVOTING
			else:
				if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					action = Action.NONE
		# Drag ball controls with left click, but only if close enough, else
		# pivot camera.
		elif mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.pressed:
				var mouse_position := get_viewport().get_mouse_position()
				var control_position := get_control_position(mouse_position)
				var ball_distance := control_position.length()
				arrow.move_to(control_position)
				if ball_distance < DRAG_THRESHOLD:
					action = Action.DRAGGING
				else:
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
					action = Action.PIVOTING
			else:
				if action != Action.NONE:
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					action = Action.NONE
	elif event is InputEventMouseMotion:
		var mouse_event := event as InputEventMouseMotion
		# Rotate camera spring arm when pivot button is down.
		if action == Action.PIVOTING:
			# Invert mouse movements as the coordinate origin is different.
			var rotation_y := deg_to_rad(-mouse_event.relative.x * mouse_sensitivity)
			var rotation_x := deg_to_rad(-mouse_event.relative.y * mouse_sensitivity)

			camera_spring.rotation.x += rotation_x
			# Restrict camera from rotating more than 45° from horizontal downwards.
			camera_spring.rotation.x = clampf(camera_spring.rotation.x, -PI/2, PI/4)
			camera_spring.rotation.y += rotation_y
		elif action == Action.DRAGGING:
			var mouse_position := mouse_event.global_position
			var control_position := get_control_position(mouse_position)
			arrow.move_to(control_position)


func _process(_delta: float) -> void:
	# Keep controls centred on the ball.
	controls.position = ball.position


func get_control_position(mouse_position: Vector2) -> Vector3:
	# Draw a ray cast from the camera, to the mouse position far away.
	# The ray is configured to only collide with the ball control plane,
	# so the collision is the mouse position in the same plane as the ball.
	var origin := camera.project_ray_origin(mouse_position)
	var direction := camera.project_ray_normal(mouse_position)
	var ray_length := camera.far
	var end := direction * ray_length
	ray_cast.global_position = origin
	ray_cast.target_position = end

	return ray_cast.get_collision_point() - ball.position
