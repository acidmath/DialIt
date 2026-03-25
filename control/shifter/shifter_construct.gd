extends Node2D

@onready var Dial : DialRelative = $"../ShifterDial"

func _ready() -> void:
	if Dial:
		Dial.dial_relative_rotated.connect(on_dial_rotated)

func on_dial_rotated(angle_diff : float):
	self.rotate(angle_diff/10)
