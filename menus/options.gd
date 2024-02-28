extends Control

@onready var global: Global = $/root/Global

func _on_close_button_pressed():
	# global.previous_scene could be either options or pause, this is set
	# before switching to options.
	get_tree().change_scene_to_file(global.previous_scene)
