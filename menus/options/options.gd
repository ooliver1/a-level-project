extends Control

@onready var global: GlobalScript = $"/root/Global"
@onready var tab_container: TabContainer = $TabContainer


func _ready() -> void:
	tab_container.get_tab_bar().grab_focus()


func _on_close_button_pressed() -> void:
	# global.previous_scene could be either options or pause, this is set
	# before switching to options.
	get_tree().change_scene_to_file(global.previous_scene)


func _on_tree_exiting() -> void:
	global.save_settings()
