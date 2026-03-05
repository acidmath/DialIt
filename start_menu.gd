extends Control
class_name StartMenu

@onready var start_button : Button = $VBoxContainer/StartButton
@onready var settings_button : Button = $VBoxContainer/SettingsButton
@onready var controls_button : Button = $VBoxContainer/ControlsButton
@onready var quit_button : Button = $VBoxContainer/QuitButton

func _ready() -> void:
	start_button.pressed.connect(start_button_pressed)
	settings_button.pressed.connect(settings_button_pressed)
	controls_button.pressed.connect(controls_button_pressed)
	quit_button.pressed.connect(quit_button_pressed)

func start_button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")

func settings_button_pressed():
	get_tree().change_scene_to_file("res://settings_menu.tscn")

func controls_button_pressed():
	get_tree().change_scene_to_file("res://input_mapping_menu.tscn")

func quit_button_pressed():
	get_tree().quit()
