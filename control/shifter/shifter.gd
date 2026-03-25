extends Node2D

signal engage_area_left_fork_entered
signal engage_area_left_fork_exited
signal engage_area_right_fork_entered
signal engage_area_right_fork_exited

@onready var engage_area_left_fork : Area2D = $ShifterConstruct/ShiftTrack/EngageArea_LeftFork
@onready var engage_area_right_fork : Area2D = $ShifterConstruct/ShiftTrack/EngageArea_RightFork

func _ready() -> void:
	engage_area_left_fork.engage_area_left_fork_entered.connect(on_engage_area_left_fork_entered)
	engage_area_left_fork.engage_area_left_fork_exited.connect(on_engage_area_left_fork_exited)
	engage_area_right_fork.engage_area_right_fork_entered.connect(on_engage_area_right_fork_entered)
	engage_area_right_fork.engage_area_right_fork_exited.connect(on_engage_area_right_fork_exited)

func on_engage_area_left_fork_entered() -> void:
	engage_area_left_fork_entered.emit()

func on_engage_area_left_fork_exited() -> void:
	engage_area_left_fork_exited.emit()

func on_engage_area_right_fork_entered() -> void:
	engage_area_right_fork_entered.emit()

func on_engage_area_right_fork_exited() -> void:
	engage_area_right_fork_exited.emit()
