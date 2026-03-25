extends Node2D

@onready var Dial = $"../ShifterDial"

func _ready() -> void:
	print("is there a dial 1?", Dial)
	if Dial:
		Dial.connect("dial_0_rotated", on_dial_0_rotated)

func on_dial_0_rotated(angle_diff : float):
	self.rotate(angle_diff/10)
