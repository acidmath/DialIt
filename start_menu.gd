extends Control
class_name StartMenu

signal start_game()

func start_button_pressed():
	emit_signal("start_game")
