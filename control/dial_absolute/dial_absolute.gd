extends Node2D
class_name DialAbsolute

signal dial_absolute_rotated(angle_diff : float)

@onready var dial_area2d = $Dial_Area2D

func _ready() -> void:
	dial_area2d.connect("dial_1_rotated", on_dial_1_rotated)

func on_dial_1_rotated(angle_diff : float):
	dial_absolute_rotated.emit(angle_diff)
	print("firing dial abs rotated")
