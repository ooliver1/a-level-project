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
	print(antialiasing)
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
	settings.load(SETTINGS_PATH)

	var sections := settings.get_sections()

	if sections.has("audio"):
		var buses := settings.get_section_keys("audio")
		for bus in buses:
			var db: int = settings.get_value("audio", bus)
			var index := int(bus)
			AudioServer.set_bus_volume_db(index, db)
