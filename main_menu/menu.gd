extends MarginContainer

func _ready() -> void:
	var dir := DirAccess.open("res://UI/themes")
	var files := PackedStringArray()
	for file in dir.get_files():
		if file.ends_with(".tres"):
			files.append(file)
	var length := len(files)
	var random := randi() % length
	var file := files[random]
	theme = load("res://UI/themes/" + file)
