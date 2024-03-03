extends ControlInput

const textures: KeyboardTextures = preload("./resources/keys.tres")

func get_texture(event: InputEvent) -> Texture2D:
	return textures.get_texture(event)
