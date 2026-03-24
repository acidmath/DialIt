extends RigidBody2D

var is_first_click : bool = true
var last_mouse_position : Vector2
var curr_mouse_position : Vector2

func _input(event: InputEvent) -> void:
	var event_mouse_button = event as InputEventMouseButton
	if event_mouse_button:
		if event_mouse_button.pressed:
			curr_mouse_position = event_mouse_button.position

func _physics_process(delta: float) -> void:
	if is_first_click:
		is_first_click = false
	else:
		move_shift_knob()
	last_mouse_position = curr_mouse_position

func move_shift_knob() -> void:
	if curr_mouse_position == last_mouse_position:
		return
	var mouse_diff = last_mouse_position - curr_mouse_position
	self.apply_impulse(mouse_diff)
	print(mouse_diff)
