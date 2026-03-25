extends Area2D

signal dial_1_rotated(angle_diff : float)

const snap_step : Vector2 = Vector2(0.5, 0.5)

var update_dial_progress : bool
var last_rotation : float
var last_mouse_position : Vector2 = Vector2(0, -1)

#this one just follows the input

func _ready():
	self.mouse_entered.connect(mouse_entered_button)
	self.mouse_exited.connect(mouse_exited_button)

func _process(_delta: float) -> void:
	var press_down = Input.is_action_pressed("press_down")
	# we want to look at where the mouse is relative to the center of the shape
	# and then rotate the dial with updates as long as the update bool is true
	if press_down and update_dial_progress:
		var snapped_mouse_position = get_local_mouse_position().snapped(snap_step)
		var angle_diff = last_mouse_position.angle_to(snapped_mouse_position)
		rotation += angle_diff
		rotation = snapped(rotation, PI/8)
		emit_signal("dial_1_rotated", last_rotation - rotation)
		last_rotation = rotation
	elif not press_down:
		emit_signal("dial_1_rotated", 0)

func mouse_entered_button():
	update_dial_progress = true

func mouse_exited_button():
	update_dial_progress = false
