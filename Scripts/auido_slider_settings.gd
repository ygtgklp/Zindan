extends Control

@onready var audio_name = $HBoxContainer/Audio_Name_Label as Label
@onready var audio_num = $HBoxContainer/Audio_Number_Label as Label
@onready var hslider = $HBoxContainer/HSlider as HSlider

@export_enum("Master", "Music", "SFX") var bus_name : String

var bus_index : int = 0

func _ready():
	hslider.value_changed.connect(on_value_changed)
	set_name_label_text()
	set_num_label_text()
	set_slider_value()

func set_name_label_text() -> void:
	audio_name.text = str(bus_name)

func set_num_label_text() -> void:
	audio_num.text = str(hslider.value * 100) + "%"

func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value() -> void:
	hslider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_num_label_text()

func on_value_changed(value : float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_num_label_text()

