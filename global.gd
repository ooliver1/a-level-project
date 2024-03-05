extends Node

const SETTINGS_PATH = "user://settings.ini"

enum {WINDOW_WINDOWED, WINDOW_FULLSCREEN, WINDOW_BORDERLESS}
enum {ANTIALIASING_DISABLED, ANTIALIASING_2X, ANTIALIASING_4X, ANTIALIASING_8X}

## The scene before switching, used for back/close menu buttons.
var previous_scene: String
## The control input that is currently listening.
var listening_control: ControlInput
## Config file for holding modified settings.
var settings := ConfigFile.new()

func _ready() -> void:
	load_settings()

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
	if antialiasing == Viewport.MSAA_2X:
		id = ANTIALIASING_2X
	elif antialiasing == Viewport.MSAA_4X:
		id = ANTIALIASING_4X
	elif antialiasing == Viewport.MSAA_8X:
		id = ANTIALIASING_8X

	return id

func store_event(action: StringName, event: InputEvent) -> void:
	if event is InputEventKey:
		# Similar to prompts/resources/keys.gd#get_texture
		var key_event := event as InputEventKey
		var keycode := key_event.keycode
		if keycode == 0:
			var physical := key_event.physical_keycode
			keycode = DisplayServer.keyboard_get_keycode_from_physical(physical)

		settings.set_value("controls", action + "_key", keycode)
	elif event is InputEventJoypadButton:
		var joypad_event := event as InputEventJoypadButton
		var button := joypad_event.button_index

		settings.set_value("controls", action + "_control", button)

func set_window_mode(mode: int) -> void:
	if mode == 0:
		# Windowed windows have a border and this sets it to maximised for a
		# consistent size when switching away from fullscreen.
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	elif mode == 1:
		DisplayServer.window_set_position(Vector2i(0, 0))
		# Exclusive fullscreen has a lower overhead as it usually avoids
		# the display compositor.
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif mode == 2:
		# Fullscreen borderless is a full screen sized window without a border.
		# It usually works better with multiple monitor setups when alt+tab/esc
		# in windows.
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_size(DisplayServer.screen_get_size())
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		DisplayServer.window_set_position(Vector2i(0, 0))

func set_antialiasing(mode: int) -> void:
	var viewport := get_viewport()

	if mode == 0:
		viewport.msaa_2d = Viewport.MSAA_DISABLED
		viewport.msaa_3d = Viewport.MSAA_DISABLED
	elif mode == 1:
		viewport.msaa_2d = Viewport.MSAA_2X
		viewport.msaa_3d = Viewport.MSAA_2X
	elif mode == 2:
		viewport.msaa_2d = Viewport.MSAA_4X
		viewport.msaa_3d = Viewport.MSAA_4X
	elif mode == 3:
		viewport.msaa_2d = Viewport.MSAA_8X
		viewport.msaa_3d = Viewport.MSAA_8X

func save_settings() -> void:
	var bus_count := AudioServer.bus_count
	for bus in range(bus_count):
		var db := AudioServer.get_bus_volume_db(bus)
		settings.set_value("audio", str(bus), db)

	var vsync := DisplayServer.window_get_vsync_mode()
	var video_mode := get_window_mode()
	var video_antialiasing := get_antialiasing()
	var video_vsync_enabled := vsync == DisplayServer.VSYNC_ENABLED

	settings.set_value("video", "mode", video_mode)
	settings.set_value("video", "antialiasing", video_antialiasing)
	settings.set_value("video", "vsync", video_vsync_enabled)

	var actions := InputMap.get_actions()
	for action in actions:
		# ui_* are default UI traversal controls.
		if not action.begins_with("ui_"):
			var events := InputMap.action_get_events(action)
			for event in events:
				store_event(action, event)

	settings.save(SETTINGS_PATH)

func load_settings() -> void:
	var err := settings.load(SETTINGS_PATH)
	if err == ERR_FILE_CANT_OPEN:
		return

	# Audio
	var buses := settings.get_section_keys("audio")
	for bus in buses:
		var db: int = settings.get_value("audio", bus)
		var index := int(bus)
		AudioServer.set_bus_volume_db(index, db)

	# Video
	var mode: int = settings.get_value("video", "mode")
	set_window_mode(mode)

	var antialiasing: int = settings.get_value("video", "antialiasing")
	set_antialiasing(antialiasing)

	var vsync: bool = settings.get_value("video", "vsync")
	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

	# Controls
	var controls := settings.get_section_keys("controls")
	for stored_control in controls:
		if stored_control.ends_with("_key"):
			var control := stored_control.trim_suffix("_key")
			for existing_event in InputMap.action_get_events(control):
				if existing_event is InputEventKey:
					InputMap.action_erase_event(control, existing_event)
			var new_event := InputEventKey.new()
			new_event.keycode = settings.get_value("controls", stored_control)
			InputMap.action_add_event(control, new_event)
		elif stored_control.ends_with("_control"):
			var control := stored_control.trim_suffix("_control")
			for existing_event in InputMap.action_get_events(control):
				if existing_event is InputEventJoypadButton:
					InputMap.action_erase_event(control, existing_event)
			var new_event := InputEventJoypadButton.new()
			new_event.button_index = settings.get_value("controls", stored_control)
			InputMap.action_add_event(control, new_event)
