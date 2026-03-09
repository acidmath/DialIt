extends Area2D

var update_dial_progress : bool
var initial_mouse_position_set : bool
var last_mouse_position : Vector2

#this is the relative dial

func _ready():
	self.mouse_entered.connect(mouse_entered_button)
	self.mouse_exited.connect(mouse_exited_button)

func _process(_delta: float) -> void:
	var press_down = Input.is_action_pressed("press_down")
	# we want to look at where the mouse is relative to the center of the shape
	# and then rotate the dial with updates as long as the update bool is true
	if press_down and update_dial_progress:
		if initial_mouse_position_set:
			#move the dial based on the rotation from the last position to the current
			var angle_diff = last_mouse_position.angle_to(get_local_mouse_position())
			rotate(angle_diff)
		else:
			initial_mouse_position_set = true
		last_mouse_position = get_local_mouse_position()
	elif not press_down:
		initial_mouse_position_set = false

func mouse_entered_button():
	update_dial_progress = true

func mouse_exited_button():
	update_dial_progress = false
	initial_mouse_position_set = false
