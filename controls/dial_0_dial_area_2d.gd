extends Area2D

var update_dial_progress : bool

func _ready():
	self.mouse_entered.connect(mouse_entered_button)
	self.mouse_exited.connect(mouse_exited_button)

func _process(delta: float) -> void:
	var press_down = Input.is_action_pressed("press_down")
	if press_down and update_dial_progress:
		print("my global position")
		print(global_position)
		print("mouse global position")
		print(get_global_mouse_position())
		print("mouse local position")
		print(get_local_mouse_position())
		pass
		# we want to look at where the mouse is relative to the center of the shape
		# and then rotate the dial with updates as long as the update bool is true

func mouse_entered_button():
	update_dial_progress = true

func mouse_exited_button():
	update_dial_progress = false
