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
	# 0: Windowed
	# 1: Fullscreen
	# 2: Fullscreen Borderless
	if index == 0:
		# Windowed windows have a border and this sets it to maximised for a
		# consistent size when switching away from fullscreen.
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	elif index == 1:
		DisplayServer.window_set_position(Vector2i(0, 0))
		# Exclusive fullscreen has a lower overhead as it usuaully avoids
		# the display compositor.
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif index == 2:
		# Fullscreen borderless is a full screen sized window without a border.
		# It usually works better with multiple monitor setups when alt+tab/esc
		# in windows.
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_size(DisplayServer.screen_get_size())
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		DisplayServer.window_set_position(Vector2i(0, 0))


func _on_anti_aliasing_item_selected(index: int) -> void:
	var viewport := get_viewport()
	if index == 0:
		viewport.msaa_2d = Viewport.MSAA_DISABLED
		viewport.msaa_3d = Viewport.MSAA_DISABLED
	elif index == 1:
		viewport.msaa_2d = Viewport.MSAA_2X
		viewport.msaa_3d = Viewport.MSAA_2X
	elif index == 2:
		viewport.msaa_2d = Viewport.MSAA_4X
		viewport.msaa_3d = Viewport.MSAA_4X
	elif index == 3:
		viewport.msaa_2d = Viewport.MSAA_8X
		viewport.msaa_3d = Viewport.MSAA_8X


func _on_vsync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
