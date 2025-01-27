extends RigidBody2D
const ENGINE_FORCE_STEP_MAX = 10
const THRUST_DELTA_UPDATE_THRESHOLD = 0.5
const TopPosition = Vector2(0, -64)
var engineForceStep = 0
var engineForce = 200.0
var spinForce = 100.0
var lastThrustDeltaUpdate = 0
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var fire_sprite_2d = $FireSprite2D

func _physics_process(_delta):
	if Input.is_action_pressed("lRot"):
		apply_force(Vector2.from_angle(rotation + PI) * spinForce, TopPosition.rotated(rotation))
		print(Vector2.from_angle(rotation + PI))
	if Input.is_action_pressed("rRot"):
		apply_force(Vector2.from_angle(rotation) * spinForce, TopPosition.rotated(rotation))
		print(Vector2.from_angle(rotation))
	if Input.is_action_pressed("thrust"):
		if engineForceStep < ENGINE_FORCE_STEP_MAX:
			engineForceStep += 1
		
		apply_central_force(Vector2.from_angle(rotation - PI/2) * engineForce * engineForceStep)
	elif engineForceStep > 0:
		engineForceStep -= 1
	
	if engineForceStep == 0:
		fire_sprite_2d.visible = false
		audio_stream_player_2d.stream_paused = true
	else:
		fire_sprite_2d.visible = true
		audio_stream_player_2d.stream_paused = false
		fire_sprite_2d.scale.x = engineForceStep * 0.1
		fire_sprite_2d.scale.y = engineForceStep * 0.1
		audio_stream_player_2d.volume_db = linear_to_db(abs(engineForceStep) * 0.1)
		
