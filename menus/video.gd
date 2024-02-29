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


func _on_display_mode_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_anti_aliasing_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_vsync_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
