class_name ControlInput
extends Button

# Whether to act upon new `gui_input` events.
var listening: bool = false
# The texture to revert to if this input is unselected.
var previous_texture: Texture2D = null

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var global: Global = $"/root/Global"


func _on_pressed() -> void:
	# Don't redo the same process if we are already listening, as that will
	# cann `unlisten` below.
	if listening:
		return
	# Store the previous texture to revert to later if needed.
	previous_texture = texture_rect.texture
	texture_rect.texture = null
	label.text = "Waiting for input..."

	listening = true
	if global.listening_control != null:
		global.listening_control.unlisten()
	global.listening_control = self


func _on_gui_input(event: InputEvent) -> void:
	if not listening:
		return
	var texture := get_texture(event)
	if texture == null:
		return

	accept_event()

	label.text = ""
	texture_rect.texture = texture

	listening = false
	global.listening_control = null


func _on_tree_exited() -> void:
	unlisten()


# Called either when this node is not visible (`tree_exited`), or a different
# control input is selected (see above).
func unlisten() -> void:
	listening = false
	label.text = ""
	texture_rect.texture = previous_texture


# keep `get_texture` abstract, for separate key inputs and controller inputs.
func get_texture(_event: InputEvent) -> Texture2D:
	return null
