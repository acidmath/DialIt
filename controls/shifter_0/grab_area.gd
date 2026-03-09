extends Area2D
class_name GrabArea

signal mouse_entered_grab
signal mouse_exited_grab

func _mouse_enter() -> void:
	mouse_entered_grab.emit()

func _mouse_exit() -> void:
	mouse_exited_grab.emit()
