extends Node2D

@onready var track_area : TrackArea = $TrackArea
@onready var grab_area : GrabArea = $GrabArea

var track_area_entered : bool
var grab_area_entered : bool
var last_mouse_position : Vector2

func _ready() -> void:
	track_area.mouse_entered_track.connect(on_track_area_entered)
	track_area.mouse_exited_track.connect(on_track_area_exited)
	grab_area.mouse_entered_grab.connect(on_grab_area_entered)
	grab_area.mouse_exited_grab.connect(on_grab_area_exited)

func _process(_delta: float) -> void:
	if track_area_entered and grab_area_entered and Input.is_action_pressed("press_down"):
		var mouse_diff = get_local_mouse_position() - last_mouse_position
		grab_area.translate(mouse_diff)
		last_mouse_position = get_local_mouse_position()

func on_track_area_entered():
	last_mouse_position = get_local_mouse_position()
	track_area_entered = true

func on_track_area_exited():
	track_area_entered = false

func on_grab_area_entered():
	last_mouse_position = get_local_mouse_position()
	grab_area_entered = true

func on_grab_area_exited():
	grab_area_entered = false
