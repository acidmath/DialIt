extends Node2D

@onready var track_area : TrackArea = $TrackArea
@onready var grab_area : GrabArea = $GrabArea

var track_area_entered : bool
var grab_area_entered : bool
var initial_shift : bool
var do_raycast_query : bool
var grab_out_of_bounds : bool
var curr_mouse_position : Vector2
var last_mouse_position : Vector2
var last_good_grab_position : Vector2

func _ready() -> void:
	do_raycast_query = false
	grab_out_of_bounds = false
	track_area.mouse_entered_track.connect(on_track_area_entered)
	track_area.mouse_exited_track.connect(on_track_area_exited)
	grab_area.mouse_entered_grab.connect(on_grab_area_entered)
	grab_area.mouse_exited_grab.connect(on_grab_area_exited)

func _process(_delta: float) -> void:
	if grab_out_of_bounds:
		grab_area.position = last_good_grab_position
		grab_out_of_bounds = false
		return
	#this should move to an entirely different script
	#print(Input.get_accelerometer())
	if track_area_entered and grab_area_entered and Input.is_action_pressed("press_down"):
		if !initial_shift:
			#print("moving shifter")
			var mouse_diff = curr_mouse_position - last_mouse_position
			grab_area.translate(mouse_diff)
		else:
			print("setting initial position")
			initial_shift = false
			last_good_grab_position = grab_area.position
		last_mouse_position = curr_mouse_position

func _physics_process(delta: float) -> void:
	if !do_raycast_query:
		return
	do_raycast_query = false
	var grab_area_radius : float = grab_area.collision_shape_radius
	var grab_area_left = grab_area.global_position + Vector2(-grab_area_radius, 0)
	var grab_area_top = grab_area.global_position + Vector2(0, -grab_area_radius)
	var grab_area_right = grab_area.global_position + Vector2(grab_area_radius, 0)
	var grab_area_bottom = grab_area.global_position + Vector2(0, grab_area_radius)
	var space_state = get_world_2d().direct_space_state
	var query_left = PhysicsRayQueryParameters2D.create(grab_area_left, Vector2.ZERO)
	var query_top = PhysicsRayQueryParameters2D.create(grab_area_top, Vector2.ZERO)
	var query_right = PhysicsRayQueryParameters2D.create(grab_area_right, Vector2.ZERO)
	var query_bottom = PhysicsRayQueryParameters2D.create(grab_area_bottom, Vector2.INF)
	query_left.hit_from_inside = true
	query_top.hit_from_inside = true
	query_right.hit_from_inside = true
	query_bottom.hit_from_inside = true
	query_left.collide_with_areas = true
	query_top.collide_with_areas = true
	query_right.collide_with_areas = true
	query_bottom.collide_with_areas = true
	query_left.exclude = [grab_area]
	query_top.exclude = [grab_area]
	query_right.exclude = [grab_area]
	query_bottom.exclude = [grab_area]
	var result_left : Dictionary = space_state.intersect_ray(query_left)
	var result_top : Dictionary = space_state.intersect_ray(query_top)
	var result_right : Dictionary = space_state.intersect_ray(query_right)
	var result_bottom : Dictionary = space_state.intersect_ray(query_bottom)
	if result_left and result_top and result_right and result_bottom:
		last_good_grab_position = grab_area.position
	else:
		grab_out_of_bounds = true
		print("out of bounds")

func _input(event: InputEvent) -> void:
	# when there is an input event that is moving the input position
	# we'll save it for the processing function
	var screen_touch_event : InputEventScreenTouch = event as InputEventScreenTouch
	if screen_touch_event:
		curr_mouse_position = screen_touch_event.position
		do_raycast_query = true
		return
	var screen_drag_event : InputEventScreenDrag = event as InputEventScreenDrag
	if screen_drag_event:
		curr_mouse_position = screen_drag_event.position
		do_raycast_query = true
		return
	var mouse_motion_event : InputEventMouseMotion = event as InputEventMouseMotion
	if mouse_motion_event:
		curr_mouse_position = mouse_motion_event.position
		do_raycast_query = true #not great, but still better than just all the time
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
