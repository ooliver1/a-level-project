extends MarginContainer

@onready var display_mode: OptionButton = %DisplayMode
@onready var anti_aliasing: OptionButton = %AntiAliasing
@onready var v_sync: CheckBox = %VSync

const ANTIALIASING_2D = &"rendering/anti_aliasing/quality/msaa_2d"
const ANTIALIASING_3D = &"rendering/anti_aliasing/quality/msaa_3d"


func _ready() -> void:
	# 0: Windowed
	# 1: Fullscreen
	# 2: Fullscreen Borderless
	var mode := DisplayServer.window_get_mode()
	var borderless := DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	var id := 0
	if mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		id = 1
	elif mode == DisplayServer.WINDOW_MODE_WINDOWED and borderless:
		id = 2
	display_mode.select(id)

	# msaa_2d and msaa_3d are the same here
	var antialiasing := get_viewport().msaa_2d
	id = 0
	if antialiasing == Viewport.MSAA_2X:
		id = 1
	elif antialiasing == Viewport.MSAA_4X:
		id = 2
	elif antialiasing == Viewport.MSAA_8X:
		id = 3
	anti_aliasing.select(id)

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
	# 0: Disabled
	# 1: MSAA 2x
	# 2: MSAA 4x
	# 3: MSAA 8x
	if index == 0:
		ProjectSettings.set_setting(ANTIALIASING_2D, Viewport.MSAA_DISABLED)
		ProjectSettings.set_setting(ANTIALIASING_3D, Viewport.MSAA_DISABLED)
	elif index == 1:
		ProjectSettings.set_setting(ANTIALIASING_2D, Viewport.MSAA_2X)
		ProjectSettings.set_setting(ANTIALIASING_3D, Viewport.MSAA_2X)
	elif index == 2:
		ProjectSettings.set_setting(ANTIALIASING_2D, Viewport.MSAA_4X)
		ProjectSettings.set_setting(ANTIALIASING_3D, Viewport.MSAA_4X)
	elif index == 3:
		ProjectSettings.set_setting(ANTIALIASING_2D, Viewport.MSAA_8X)
		ProjectSettings.set_setting(ANTIALIASING_3D, Viewport.MSAA_8X)


func _on_vsync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
