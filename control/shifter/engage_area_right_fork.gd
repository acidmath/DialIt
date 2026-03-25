extends Area2D
class_name EngageAreaRight

signal engage_area_right_fork_entered
signal engage_area_right_fork_exited

func _ready() -> void:
	self.connect("body_entered", on_body_entered )
	self.connect("body_exited", on_body_exited )

func on_body_entered(body : Node2D):
	var shift_knob = body as ShiftKnob
	if shift_knob:
		engage_area_right_fork_entered.emit()

func on_body_exited(body : Node2D):
	var shift_knob = body as ShiftKnob
	if shift_knob:
		engage_area_right_fork_exited.emit()
