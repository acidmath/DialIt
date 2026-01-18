extends Control
class_name SettingsMenu

func _ready() -> void:
	var slider = self.get_node("./VBoxContainer/VolumeContainer/VolumeSlider")
	slider.value = PlayerSettings.volume * 10

func return_button_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")

func volume_changed(volume : float):
	PlayerSettings.volume = volume / 10
