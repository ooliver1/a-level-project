extends MarginContainer

@onready var display_mode: OptionButton = %DisplayMode
@onready var anti_aliasing: OptionButton = %AntiAliasing
@onready var v_sync: CheckBox = %VSync
@onready var global: Global = $"/root/Global"


func _ready() -> void:
	var video_mode: int = global.get_window_mode()
	display_mode.select(video_mode)

	var antialiasing: int = global.get_antialiasing()
	anti_aliasing.select(antialiasing)

	var vsync := DisplayServer.window_get_vsync_mode()
	if vsync == DisplayServer.VSYNC_ENABLED:
		v_sync.set_pressed_no_signal(true)
	else:
		v_sync.set_pressed_no_signal(false)


func _on_display_mode_item_selected(index: int) -> void:
	global.set_window_mode(index)


func _on_anti_aliasing_item_selected(index: int) -> void:
	global.set_antialiasing(index)


func _on_vsync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
