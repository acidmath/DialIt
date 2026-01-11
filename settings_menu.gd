extends Control

signal settings_return()

func return_button_pressed():
	emit_signal("settings_return")
