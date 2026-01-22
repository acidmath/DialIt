extends Control
class_name InputMappingMenu

var isReassigning : bool

func _process(delta: float) -> void:
	if Input.is_action_just_released("esc"):
		if isReassigning:
			%InputReassignmentPanel.visible = false
			isReassigning = false
		else:
			return_to_main_menu()

func return_to_main_menu():
	get_tree().change_scene_to_file("res://start_menu.tscn")

func show_reassignment_dialog(action : String):
	if isReassigning:
		pass
	isReassigning = true
	%InputReassignmentPanel.visible = true
	%InputMappingInstructionsLabel.text = "Please press the button you want to assign to " + action

func thrust_button_pressed():
	show_reassignment_dialog("thrust")
