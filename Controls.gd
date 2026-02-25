extends RigidBody2D
class_name PlayerController

signal player_defeated(player : PlayerController, collision_normal : Vector2)

const ENGINE_FORCE_STEP_MAX = 10
const THRUST_DELTA_UPDATE_THRESHOLD = 0.5
const TopPosition = Vector2(0, -64)

var hasBeenDefeated = false
var engineForceStep = 0
var engineForce = 200.0
var spinForce = 100.0
var lastThrustDeltaUpdate = 0
var lastContactNormal : Vector2

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var fire_sprite_2d = $FireSprite2D
@onready var collision_shape = $CollisionShape2D

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
		audio_stream_player_2d.volume_db = linear_to_db(abs(engineForceStep) * 0.1 * PlayerSettings.volume)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.get_contact_count() > 0:
		lastContactNormal = state.get_contact_local_normal(0)

func _on_body_entered(body: Node2D):
	if hasBeenDefeated:
		return
	var platform = body as LandingPlatform
	if platform:
		get_tree().call_deferred("reload_current_scene")
	else:
		hasBeenDefeated = true
		player_defeated.emit(self, lastContactNormal)
