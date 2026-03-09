extends Area2D
class_name TrackArea

signal mouse_entered_track
signal mouse_exited_track

@onready var collision_shape : CollisionPolygon2D = $CollisionPolygon2D
@onready var drawn_shape : Polygon2D = $CollisionPolygon2D/Polygon2D

func _ready() -> void:
	var collision_polygon : PackedVector2Array = collision_shape.polygon
	drawn_shape.polygon = collision_polygon

func _mouse_enter() -> void:
	mouse_entered_track.emit()

func  _mouse_exit() -> void:
	mouse_exited_track.emit()
