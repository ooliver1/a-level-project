extends Node

enum {WINDOW_WINDOWED, WINDOW_FULLSCREEN, WINDOW_BORDERLESS}
enum {ANTIALIASING_DISABLED, ANTIALIASING_2X, ANTIALIASING_4X, ANTIALIASING_8X}

## The scene before switching, used for back/close menu buttons.
var previous_scene: String
## The control input that is currently listening.
var listening_control: ControlInput
## Config file for holding modified settings.
var settings := ConfigFile.new()


func get_window_mode() -> int:
	var mode := DisplayServer.window_get_mode()
	var borderless := DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	var id := WINDOW_WINDOWED
	if mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		id = WINDOW_FULLSCREEN
	elif mode == DisplayServer.WINDOW_MODE_WINDOWED and borderless:
		id = WINDOW_BORDERLESS

	return id


func get_antialiasing() -> int:
	# msaa_2d and msaa_3d are the same here
	var antialiasing := get_viewport().msaa_2d
	var id := ANTIALIASING_DISABLED
	print(antialiasing)
	if antialiasing == Viewport.MSAA_2X:
		id = ANTIALIASING_2X
	elif antialiasing == Viewport.MSAA_4X:
		id = ANTIALIASING_4X
	elif antialiasing == Viewport.MSAA_8X:
		id = ANTIALIASING_8X

	return id


func save_settings() -> void:
	var vsync := DisplayServer.window_get_vsync_mode()
	var video_mode := get_window_mode()
	var video_antialiasing := get_antialiasing()
	var video_vsync_enabled := vsync == DisplayServer.VSYNC_ENABLED

	settings.set_value("video", "mode", video_mode)
	settings.set_value("video", "antialiasing", video_antialiasing)
	settings.set_value("video", "vsync", video_vsync_enabled)

	settings.save("user://settings.ini")
