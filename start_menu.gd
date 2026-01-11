extends Control
class_name StartMenu

signal start_game()
signal quit_game()

func start_button_pressed():
	emit_signal("start_game")
	
func quit_button_pressed():
	emit_signal("quit_game")
