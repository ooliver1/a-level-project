class_name KeyInput
extends ControlInput

@export var action: StringName
const textures: KeyboardTextures = preload("./resources/keys.tres")


func _ready() -> void:
	var current_events := InputMap.action_get_events(action)
	for existing_event in current_events:
		if existing_event is InputEventKey:
			texture_rect.texture = get_texture(existing_event)
			break


func get_texture(event: InputEvent) -> Texture2D:
	var texture := textures.get_texture(event)
	# If it is not null, this is a valid texture, store this event as action`.
	if texture != null:
		store_action(event)
	return texture


func store_action(event: InputEvent) -> void:
	var current_events := InputMap.action_get_events(action)
	# Clear any existing key events for this current action and replace it with
	# the new one.

	for existing_event in current_events:
		if existing_event is InputEventKey:
			InputMap.action_erase_event(action, existing_event)

	InputMap.action_add_event(action, event)
