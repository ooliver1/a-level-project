extends MarginContainer

@onready var display_mode: OptionButton = %DisplayMode
@onready var anti_aliasing: OptionButton = %AntiAliasing
@onready var v_sync: CheckBox = %VSync


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
	var antialiasing = get_viewport().msaa_2d
	id = 0
	if antialiasing == Viewport.MSAA_2X:
		id = 1
	elif antialiasing == Viewport.MSAA_4X:
		id = 2
	elif antialiasing == Viewport.MSAA_8X:
		id = 3


func _on_display_mode_item_selected(index: int) -> void:
	# 0: Windowed
	# 1: Fullscreen
	# 2: Fullscreen Borderless
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		DisplayServer.window_set_size(DisplayServer.screen_get_size())

func _on_anti_aliasing_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_vsync_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
