extends Control

@onready var global: Global = $/root/Global

func _on_close_button_pressed():
	get_tree().change_scene_to_file(global.previous_scene)
