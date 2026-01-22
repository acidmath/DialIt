extends Control
class_name InputMappingMenu

var isReassigning : bool

func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		if isReassigning:
			%InputReassignmentPanel.visible = false
			isReassigning = false
		else:
			return_to_main_menu()

func return_to_main_menu():
	get_tree().change_scene_to_file("res://start_menu.tscn")

func thrust_button_pressed():
	pass
	#showDialog("thrust")
