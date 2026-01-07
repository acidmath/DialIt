extends Control

var slider : HSlider

func _ready() -> void:
	slider = self.get_node("./PanelContainer/HBoxContainer/VBoxContainer2/VolumeSlider")
	slider.value = PlayerSettings.volume * 10

func _process(_delta):
	testesc()

func volume_changed(volume : float):
	PlayerSettings.volume = volume / 10

func resume():
	get_tree().paused = false
	self.visible = false

func pause():
	get_tree().paused = true
	self.visible = true

func testesc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

func endGame(_player, _collision_normal):
	self.visible = true
