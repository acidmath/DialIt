extends Camera2D

const zoomInCoeff = 1.05
const zoomOutCoeff = 0.95
const minZoom = 0.2
const maxZoom = 2

@onready var rigid_body_2d = $"../RigidBody2D"

func _process(_delta):
	if rigid_body_2d != null:
		self.global_position = rigid_body_2d.global_position
	
	if Input.is_action_pressed("ZoomIn") and zoom.x < maxZoom:
		zoom.x *= zoomInCoeff
		zoom.y *= zoomInCoeff
	elif Input.is_action_pressed("ZoomOut") and zoom.x > minZoom:
		zoom.x *= zoomOutCoeff
		zoom.y *= zoomOutCoeff
