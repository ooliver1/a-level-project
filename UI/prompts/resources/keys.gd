@tool
class_name KeyboardTextures
extends Resource

# All keys that can reasonably be used as custom controls.
# This means no modifier keys, no mouse buttons, no keys which do not usually
# pass through to programs such as numlock,
const _KEYS: Array[Key] = [
	KEY_0,
	KEY_1,
	KEY_2,
	KEY_3,
	KEY_4,
	KEY_5,
	KEY_6,
	KEY_7,
	KEY_8,
	KEY_9,
	KEY_A,
	KEY_B,
	KEY_C,
	KEY_D,
	KEY_E,
	KEY_F,
	KEY_G,
	KEY_H,
	KEY_I,
	KEY_J,
	KEY_K,
	KEY_L,
	KEY_M,
	KEY_N,
	KEY_O,
	KEY_P,
	KEY_Q,
	KEY_R,
	KEY_S,
	KEY_T,
	KEY_U,
	KEY_V,
	KEY_W,
	KEY_X,
	KEY_Y,
	KEY_Z,
	KEY_APOSTROPHE,
	KEY_LEFT,
	KEY_RIGHT,
	KEY_UP,
	KEY_DOWN,
	KEY_ASTERISK,
	KEY_BACKSPACE,
	KEY_BRACKETLEFT,
	KEY_BRACKETRIGHT,
	KEY_GREATER,
	KEY_LESS,
	KEY_CAPSLOCK,
	KEY_ASCIICIRCUM,
	KEY_COLON,
	KEY_COMMA,
	KEY_DELETE,
	KEY_END,
	KEY_ENTER,
	KEY_ESCAPE,
	KEY_EXCLAM,
	KEY_F1,
	KEY_F2,
	KEY_F3,
	KEY_F4,
	KEY_F5,
	KEY_F6,
	KEY_F7,
	KEY_F8,
	KEY_F9,
	KEY_F10,
	KEY_F11,
	KEY_F12,
	KEY_HOME,
	KEY_INSERT,
	KEY_MINUS,
	KEY_PAGEDOWN,
	KEY_PAGEUP,
	KEY_PERIOD,
	KEY_PLUS,
	KEY_PRINT,
	KEY_QUESTION,
	KEY_QUOTEDBL,
	KEY_SEMICOLON,
	KEY_SLASH,
	KEY_BACKSLASH,
	KEY_SPACE,
	KEY_ASCIITILDE,
	KEY_TAB,
]

var textures: Dictionary = {}


func _init() -> void:
	for k in _KEYS:
		textures[OS.get_keycode_string(k)] = null


# Make this Resource act like all of its properties are contained in `textures`.
func _get(property: StringName) -> Variant:
	if property in textures.keys():
		return textures[property]
	return null


func _set(property: StringName, value: Variant) -> bool:
	if property in textures.keys():
		textures[property] = value
		return true
	return false


# Fake the properties we have as all the supported keys.
func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	for k in _KEYS:
		properties.append(
			{
				name = OS.get_keycode_string(k),
				type = TYPE_OBJECT,
				hint = PROPERTY_HINT_RESOURCE_TYPE,
				hint_string = "Texture2D"
			}
		)
	return properties


func get_texture(event: InputEvent) -> Texture2D:
	if not event is InputEventKey:
		return
	var key_event := event as InputEventKey
	var scancode := key_event.keycode
	# When accessing InputMap, this is 0
	if scancode == 0:
		var physical := key_event.physical_keycode
		scancode = DisplayServer.keyboard_get_keycode_from_physical(physical)

	return textures.get(OS.get_keycode_string(scancode), null)
