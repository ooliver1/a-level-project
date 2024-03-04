class_name ControllerInput
extends ControlInput

const xb_textures: ControllerTextures = preload("./resources/xbox.tres")
const ps_textures: ControllerTextures = preload("./resources/playstation.tres")
const ni_textures: ControllerTextures = preload("./resources/nintendo.tres")
const st_textures: ControllerTextures = preload("./resources/steam.tres")

@export var action: StringName


func _ready() -> void:
	var current_events := InputMap.action_get_events(action)
	for existing_event in current_events:
		if existing_event is InputEventJoypadButton:
			texture_rect.texture = get_texture(existing_event)
			break


func get_texture(event: InputEvent) -> Texture2D:
	var device := event.device
	var joy_name := Input.get_joy_name(device)
	# The following conditions come from the public SDL controller database
	# https://github.com/mdqinc/SDL_GameControllerDB/
	if joy_name.contains("Xbox"):
		return xb_textures.get_texture(event)
	elif (
		joy_name.contains("PlayStation")
		or joy_name.contains("PS")
		or joy_name.contains("DualShock")
	):
		return ps_textures.get_texture(event)
	elif joy_name.contains("Nintendo") or joy_name.contains("Switch"):
		return ni_textures.get_texture(event)
	elif joy_name.contains("Steam"):
		return st_textures.get_texture(event)
	else:
		return xb_textures.get_texture(event)


func store_action(event: InputEvent) -> void:
	var current_events := InputMap.action_get_events(action)
	# Clear any existing key events for this current action and replace it with
	# the new one.
	for existing_event in current_events:
		if existing_event is InputEventJoypadButton:
			InputMap.action_erase_event(action, existing_event)

	InputMap.action_add_event(action, event)
