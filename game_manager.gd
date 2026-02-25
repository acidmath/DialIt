extends Node
class_name GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene_uid = "uid://dvbl5xcd3wu8h"
	get_tree().call_deferred("change_scene_to_file", scene_uid)
