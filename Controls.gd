extends RigidBody2D
const ENGINE_FORCE_STEP_MAX = 10
const THRUST_DELTA_UPDATE_THRESHOLD = 0.5
var engine_force_step = 0
var engine_force = 200.0
var spin_force = 100.0
var lastThrustDeltaUpdate = 0
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var fire_sprite_2d = $FireSprite2D

func _physics_process(_delta):
	if Input.is_action_pressed("lRot"):
		apply_torque_impulse(-spin_force)
	if Input.is_action_pressed("rRot"):
		apply_torque_impulse(spin_force)
	if Input.is_action_pressed("thrust"):
		if(engine_force_step < ENGINE_FORCE_STEP_MAX):
			engine_force_step += 1
		
		apply_central_force(Vector2.from_angle(rotation - PI/2) * engine_force * engine_force_step)
	elif(engine_force_step > 0):
		engine_force_step -= 1
	
	if(engine_force_step == 0):
		fire_sprite_2d.visible = false
		audio_stream_player_2d.stream_paused = true
	else:
		fire_sprite_2d.visible = true
		audio_stream_player_2d.stream_paused = false
		fire_sprite_2d.scale.x = engine_force_step * 0.1
		fire_sprite_2d.scale.y = engine_force_step * 0.1
		#fire_sprite_2d.position.y = 70.0 * engine_force_step * 0.1
		audio_stream_player_2d.volume_db = linear_to_db(abs(engine_force_step) * 0.1)
		
	print(engine_force_step)
	print(fire_sprite_2d.position.y)
