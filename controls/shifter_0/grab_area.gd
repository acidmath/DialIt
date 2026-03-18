extends Area2D
class_name GrabArea

signal mouse_entered_grab
signal mouse_exited_grab

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

func _mouse_enter() -> void:
	mouse_entered_grab.emit()

func _mouse_exit() -> void:
	mouse_exited_grab.emit()
