extends Control
class_name StartMenu

signal start_game()
signal settings_menu()
signal quit_game()

func start_button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")

func settings_button_pressed():
	get_tree().change_scene_to_file("res://settings_menu.tscn")
	
func quit_button_pressed():
	get_tree().quit()
