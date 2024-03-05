@tool
extends TabContainer

func _ready() -> void:
	focus_neighbor_top = get_tab_bar().get_path()
