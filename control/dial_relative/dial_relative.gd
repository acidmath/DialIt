extends Node2D
class_name DialRelative

signal dial_relative_rotated(angle_diff : float)

@onready var dial_area2d = $Dial_Area2D

func _ready() -> void:
	dial_area2d.dial_rotated.connect(on_dial_rotated)

func on_dial_rotated(angle_diff : float):
	dial_relative_rotated.emit(angle_diff)
	print("firing dial relative rotated")
