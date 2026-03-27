extends Area2D

signal dial_rotated(angle_diff : float)

var update_dial_progress : bool
var last_rotation : float
var last_mouse_position : Vector2 = Vector2(0, -1)

#this one just follows the input
#pointing straight up is 0

func _ready():
	self.mouse_entered.connect(mouse_entered_button)
	self.mouse_exited.connect(mouse_exited_button)

func _process(_delta: float) -> void:
	if !update_dial_progress:
		return
	var press_down = Input.is_action_pressed("press_down")
	# we want to look at where the mouse is relative to the center of the shape
	# and then rotate the dial with updates as long as the update bool is true
	if press_down:
		var angle_diff = last_mouse_position.angle_to(get_local_mouse_position())
		rotation += angle_diff
		rotation = fmod(snapped(rotation, PI/8), TAU)
		if rotation < 0:
			rotation += TAU
		if last_rotation != rotation:
			var output_value = snapped(rotation / TAU, .0001)
			dial_rotated.emit(output_value)
			last_rotation = rotation

func mouse_entered_button():
	update_dial_progress = true

func mouse_exited_button():
	update_dial_progress = false
