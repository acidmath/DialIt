extends Control
class_name InputMappingMenu

var isReassigning : bool
var actionAssigning : String
@onready var inputReassignmentPanel = %InputReassignmentPanel
@onready var inputMappingInstructionsLabel = %InputMappingInstructionsLabel
@onready var thrustValueLabel = %ThrustValueLabel
@onready var rotateRightValueLabel = %RotateRightValueLabel
@onready var rotateLeftValueLabel = %RotateLeftValueLabel

func _ready() -> void:
	thrustValueLabel.text = InputMap.action_get_events("thrust")[0].as_text()
	rotateRightValueLabel.text = InputMap.action_get_events("rRot")[0].as_text()
	rotateLeftValueLabel.text = InputMap.action_get_events("lRot")[0].as_text()

func _input(event: InputEvent) -> void:
	var eventKey: InputEventKey = event as InputEventKey
	if not eventKey:
		return
	
	# if the escape key is pressed, either stop reassignment or leave the page
	if eventKey.keycode == KEY_ESCAPE:
		if isReassigning:
			stop_assignment()
		else:
			return_to_main_menu()
		return
	# when in reassignment mode, take the next key press as the key to assign the action to
	if isReassigning:
		InputMap.action_erase_events(actionAssigning)
		InputMap.action_add_event(actionAssigning, eventKey)
		update_assignment_label()
		stop_assignment()

func update_assignment_label():
	var key = InputMap.action_get_events(actionAssigning)[0].as_text()
	if actionAssigning=="thrust":
		thrustValueLabel.text = key
	elif actionAssigning=="rRot":
		rotateRightValueLabel.text = key
	elif actionAssigning=="lRot":
		rotateLeftValueLabel.text = key

func stop_assignment():
	inputReassignmentPanel.visible = false
	isReassigning = false
	actionAssigning = ""

func return_to_main_menu():
	get_tree().change_scene_to_file("uid://dvbl5xcd3wu8h")

func show_reassignment_dialog(action : String):
	if isReassigning:
		pass
	isReassigning = true
	actionAssigning = action
	inputReassignmentPanel.visible = true
	inputMappingInstructionsLabel.text = "Please press the button you want to assign to " + action

func thrust_button_pressed():
	show_reassignment_dialog("thrust")

func rotate_right_button_pressed():
	show_reassignment_dialog("rRot")
	
func rotate_left_button_pressed():
	show_reassignment_dialog("lRot")
