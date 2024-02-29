extends Control

@onready var global: Global = $"/root/Global"


	# global.previous_scene could be either options or pause, this is set
func _on_close_button_pressed() -> void:
	# before switching to options.
	get_tree().change_scene_to_file(global.previous_scene)
