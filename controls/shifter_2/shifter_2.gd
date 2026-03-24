extends Node2D

func _ready() -> void:
	var dial = $"../Camera2D/Dial_1" # there should be a dial in this shifter scene
	print("is there a dial 1?", dial)
	if dial:
		dial.connect("dial_1_rotated", on_dial_1_rotated)

func on_dial_1_rotated(angle_diff : float):
	self.rotate(angle_diff/10)
