extends VBoxContainer

@export var audio_bus_name: StringName
@onready var audio_bus_index := AudioServer.get_bus_index(audio_bus_name)
@onready var value_node: Label = %Value


func _on_slider_value_changed(value: float):
	print(value)
	AudioServer.set_bus_volume_db(audio_bus_index, linear_to_db(value))
	value_node.text = str(value) + "%"
