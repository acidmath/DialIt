extends Node2D

@onready var track_area : TrackArea = $TrackArea
@onready var grab_area : GrabArea = $GrabArea

var track_area_entered : bool
var grab_area_entered : bool
var initial_shift : bool
var curr_mouse_position : Vector2
var last_mouse_position : Vector2
var last_good_grab_position : Vector2

func _ready() -> void:
	track_area.mouse_entered_track.connect(on_track_area_entered)
	track_area.mouse_exited_track.connect(on_track_area_exited)
	grab_area.mouse_entered_grab.connect(on_grab_area_entered)
	grab_area.mouse_exited_grab.connect(on_grab_area_exited)
	for point in track_area.collision_shape.polygon:
		print(point)

func _process(_delta: float) -> void:
	#if grab_out_of_bounds:
		#grab_area.position = last_good_grab_position
		#grab_out_of_bounds = false
		#return
	#this should move to an entirely different script
	#print(Input.get_accelerometer())
	if track_area_entered and grab_area_entered and Input.is_action_pressed("press_down"):
		if !initial_shift:
			#print("moving shifter")
			var mouse_diff = curr_mouse_position - last_mouse_position
			if check_grab_translation(mouse_diff):
				grab_area.translate(mouse_diff)
		else:
			print("setting initial position")
			initial_shift = false
			last_good_grab_position = grab_area.position
		last_mouse_position = curr_mouse_position

func check_grab_translation(mouse_diff : Vector2) -> bool:
	var track_area_polygon : PackedVector2Array = track_area.collision_shape.polygon
	var grab_area_radius : float = grab_area.collision_shape_radius
	var translated_grab_area_left = grab_area.position + Vector2(-grab_area_radius, 0) + mouse_diff
	var translated_grab_area_top = grab_area.position + Vector2(0, -grab_area_radius) + mouse_diff
	var translated_grab_area_right = grab_area.position + Vector2(grab_area_radius, 0) + mouse_diff
	var translated_grab_area_bottom = grab_area.position + Vector2(0, grab_area_radius) + mouse_diff
	var left_in = Geometry2D.is_point_in_polygon(translated_grab_area_left, track_area_polygon)
	var top_in = Geometry2D.is_point_in_polygon(translated_grab_area_top, track_area_polygon)
	var right_in = Geometry2D.is_point_in_polygon(translated_grab_area_right, track_area_polygon)
	var bottom_in = Geometry2D.is_point_in_polygon(translated_grab_area_bottom, track_area_polygon)
	print(left_in, " ", top_in, " ", right_in, " ", bottom_in)
	return left_in and top_in and right_in and bottom_in

func _input(event: InputEvent) -> void:
	# when there is an input event that is moving the input position
	# we'll save it for the processing function
	var screen_touch_event : InputEventScreenTouch = event as InputEventScreenTouch
	if screen_touch_event:
		curr_mouse_position = screen_touch_event.position
		return
	var screen_drag_event : InputEventScreenDrag = event as InputEventScreenDrag
	if screen_drag_event:
		curr_mouse_position = screen_drag_event.position
		return
	var mouse_motion_event : InputEventMouseMotion = event as InputEventMouseMotion
	if mouse_motion_event:
		curr_mouse_position = mouse_motion_event.position
		return
	# when the press down input is released, we'll reset the initial position
	var mouse_button_event : InputEventMouseButton = event as InputEventMouseButton
	if mouse_button_event and !mouse_button_event.pressed:
		initial_shift = true
		return

func on_track_area_entered():
	initial_shift = grab_area_entered
	track_area_entered = true

func on_track_area_exited():
	track_area_entered = false

func on_grab_area_entered():
	initial_shift = track_area_entered
	grab_area_entered = true

func on_grab_area_exited():
	grab_area_entered = false
