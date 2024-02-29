@tool
class_name MarginStyleBox extends StyleBox

@export var style_box: StyleBox:
	set(value):
		style_box = value
		emit_changed()
@export var padding_left: int = 0:
	set(value):
		padding_left = value
		emit_changed()
@export var padding_top: int = 0:
	set(value):
		padding_top = value
		emit_changed()
@export var padding_right: int = 0:
	set(value):
		padding_right = value
		emit_changed()
@export var padding_bottom: int = 0:
	set(value):
		padding_bottom = value
		emit_changed()


func _draw(to_canvas_item: RID, rect: Rect2) -> void:
	var new_rect: Rect2 = rect.grow_individual(
		-padding_left, -padding_top, -padding_right, -padding_bottom
	)
	if style_box:
		style_box.draw(to_canvas_item, new_rect)
