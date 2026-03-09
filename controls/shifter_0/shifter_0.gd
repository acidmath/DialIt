extends Node2D

@onready var track_area : TrackArea = $TrackArea
@onready var grab_area : GrabArea = $GrabArea

var track_area_entered : bool
var grab_area_entered : bool

func _ready() -> void:
	track_area.mouse_entered_track.connect(on_track_area_entered)
	track_area.mouse_exited_track.connect(on_track_area_exited)
	grab_area.mouse_entered_grab.connect(on_grab_area_entered)
	grab_area.mouse_exited_grab.connect(on_grab_area_exited)

func _process(_delta: float) -> void:
	if track_area_entered and grab_area_entered and Input.is_action_pressed("press_down"):
		grab_area.global_position = get_global_mouse_position()

func on_track_area_entered():
	track_area_entered = true
	print("track entered")

func on_track_area_exited():
	track_area_entered = false
	print("track exited")

func on_grab_area_entered():
	grab_area_entered = true
	print("grab entered")

func on_grab_area_exited():
	grab_area_entered = false
	print("grab exited")
