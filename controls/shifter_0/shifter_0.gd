extends Node2D

@onready var track_area : TrackArea = $TrackArea
@onready var grab_area : GrabArea = $GrabArea

var track_area_entered : bool
var grab_area_entered : bool
var initial_shift : bool
var curr_mouse_position : Vector2
var last_mouse_position : Vector2

func _ready() -> void:
	track_area.mouse_entered_track.connect(on_track_area_entered)
	track_area.mouse_exited_track.connect(on_track_area_exited)
	grab_area.mouse_entered_grab.connect(on_grab_area_entered)
	grab_area.mouse_exited_grab.connect(on_grab_area_exited)

func _process(_delta: float) -> void:
	if track_area_entered and grab_area_entered and Input.is_action_pressed("press_down"):
		if !initial_shift:
			var mouse_diff = curr_mouse_position - last_mouse_position
			grab_area.translate(mouse_diff)
		else:
			initial_shift = false
		last_mouse_position = curr_mouse_position

func _input(event: InputEvent) -> void:
	
	var screen_touch_event : InputEventScreenTouch = event as InputEventScreenTouch
	if screen_touch_event:
		curr_mouse_position = screen_touch_event.position
		return
	var screen_drag_event : InputEventScreenDrag = event as InputEventScreenDrag
	if screen_drag_event:
		curr_mouse_position = screen_drag_event.position
		return
	var mouse_event : InputEventMouse = event as InputEventMouse
	if mouse_event:
		curr_mouse_position = mouse_event.position
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
