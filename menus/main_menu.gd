extends MarginContainer

# Take in scenes as an exported property, to reduce coupling.
@export var play_scene: PackedScene
@export var options_scene: PackedScene
@onready var global: Global = $"/root/Global"


func _on_quit_button_pressed():
	# `get_tree()` gets the `SceneTree` which manages the game loop.
	get_tree().quit()


func _on_options_button_pressed():
	var tree := get_tree()
	global.previous_scene = tree.current_scene.scene_file_path
	tree.change_scene_to_packed(options_scene)


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(play_scene)
