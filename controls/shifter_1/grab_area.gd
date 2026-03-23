extends GrabArea
#class_name GrabArea

#signal mouse_entered_grab
#signal mouse_exited_grab
#
#@onready var collision_shape : CollisionShape2D = $CollisionShape2D
#var collision_shape_radius : float
#
#func _ready() -> void:
	#var collision_shape_shape : CircleShape2D = collision_shape.shape as CircleShape2D
	#collision_shape_radius = collision_shape_shape.radius
#
#func _mouse_enter() -> void:
	#mouse_entered_grab.emit()
#
#func _mouse_exit() -> void:
	#mouse_exited_grab.emit()
