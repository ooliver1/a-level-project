@tool
extends TabContainer


func _ready() -> void:
	print("!!!")
	focus_neighbor_top = get_tab_bar().get_path()
