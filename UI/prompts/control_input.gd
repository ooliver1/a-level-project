class_name ControlInput
extends Button

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var global: Global = $"/root/Global"

const key_textures: KeyboardTextures = preload("./resources/keys.tres")
var listening: bool = false


func _on_pressed() -> void:
	label.text = "Waiting for input..."


func _on_gui_input(event: InputEvent) -> void:
	var texture := key_textures.get_texture(event)
	print(texture)
