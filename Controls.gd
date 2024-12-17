extends RigidBody2D
var engine_force = 3000.0
var spin_force = 300.0

func _physics_process(delta):
	if Input.is_action_pressed("lRot"):
		apply_torque_impulse(-spin_force)
	if Input.is_action_pressed("rRot"):
		apply_torque_impulse(spin_force)
	if Input.is_action_pressed("thrust"):
		apply_central_force(Vector2.from_angle(rotation - PI/2) * engine_force)
