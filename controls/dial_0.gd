extends Node2D

signal dial_0_rotated(angle_diff : float)

@onready var dial_area2d = $Dial_Area2D

func _ready() -> void:
	dial_area2d.connect("dial_0_rotated", on_dial_0_rotated)

func on_dial_0_rotated(angle_diff : float):
	emit_signal("dial_0_rotated", angle_diff)
