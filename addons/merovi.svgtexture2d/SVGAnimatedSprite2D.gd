@tool
extends AnimatedSprite2D
class_name SVGAnimatedSprite2D

@export var SVGTexture: SVGTexture2D = null:
	get:
		return SVGTexture
	set(value):
		SVGTexture = value
		_update_texture()

@export var Resolution: float = 1.0:
	get:
		return Resolution
	set(value):
		Resolution = value
		_update_texture()

@export var sprite_size : float = 1.0:
	get:
		return sprite_size
	set(value):
		sprite_size = value
		_update_texture()

func _ready():
	var camera = get_viewport().get_camera_2d()
	if camera and camera is SVGCamera2D:
		(camera as SVGCamera2D).zoom_changed.connect(_on_zoom_change)

func _on_zoom_change(zoom):
	Resolution = zoom

func _update_texture():
	if SVGTexture:
		var frames = SpriteFrames.new()
		for i in range(SVGTexture.svg_data_frames.size()):
			var image = _rasterize_svg(SVGTexture.svg_data_frames[i], sprite_size * Resolution)
			var texture = ImageTexture.new()
			texture.set_image(image)
			frames.add_frame("default", texture)
		self.sprite_frames = frames
	scale = Vector2(1.0 / Resolution, 1.0 / Resolution)

func _rasterize_svg(data, scale):
	var image = Image.new()
	image.load_svg_from_string(data, scale)
	image.fix_alpha_edges()
	return image
