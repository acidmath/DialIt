extends AnimationPlayer

@onready var pause_menu : PauseMenu = $"../PauseMenu"

func _ready() -> void:
	pause_menu.resume_game.connect(on_pause_menu_resume_game)
	self.animation_finished.connect(on_animation_finished)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_menu_rollout"):
		get_tree().paused = true
		play("pause_menu_rollout")

func on_pause_menu_resume_game() -> void:
	play("pause_menu_rollin")

func on_animation_finished(animation_name : String) -> void:
	if animation_name == "pause_menu_rollin":
		get_tree().paused = false
