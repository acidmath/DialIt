extends Area2D

signal engage_area_left_fork_entered
signal engage_area_left_fork_exited

func _ready() -> void:
	self.connect("body_entered", on_body_entered )
	self.connect("body_exited", on_body_exited )

func on_body_entered(body : Node2D):
	var shift_knob = body as ShiftKnob
	if shift_knob:
		engage_area_left_fork_entered.emit(shift_knob)

func on_body_exited(body : Node2D):
	var shift_knob = body as ShiftKnob
	if shift_knob:
		engage_area_left_fork_exited.emit(shift_knob)
