extends VBoxContainer

@export var audio_bus_name: StringName
# The index of the audio bus in all buses.
@onready var audio_bus_index := AudioServer.get_bus_index(audio_bus_name)
@onready var value_node: Label = %Value

func _on_slider_value_changed(value: float):
	# Godot uses decihels, which is logorithmic. This function converts a number
	# from 0-1 into decibels (-80 to 24dB)
	var db := linear_to_db(value / 100)
	AudioServer.set_bus_volume_db(audio_bus_index, db)
	value_node.text = str(value) + "%"
