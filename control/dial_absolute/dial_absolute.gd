extends Node2D
class_name DialAbsolute

signal dial_absolute_rotated(angle : float)

@onready var dial_area2d = $Dial_Area2D

func _ready() -> void:
	dial_area2d.connect("dial_rotated", on_dial_rotated)

func on_dial_rotated(angle : float):
	dial_absolute_rotated.emit(angle)
