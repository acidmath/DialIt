extends Node

var menuScene = preload("res://start_menu.tscn")
var menuSceneInstance : StartMenu

var gameScene = preload("res://settings_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menuSceneInstance = menuScene.instantiate()
	add_child(menuSceneInstance)
	
	menuSceneInstance.start_game.connect(start_game)
	menuSceneInstance.quit_game.connect(quit_game)

func start_game():
	remove_child(menuSceneInstance)
	menuSceneInstance.queue_free()
	
	var gameSceneInstance = gameScene.instantiate()
	add_child(gameSceneInstance)
	
func quit_game():
	print("quit")
	get_tree().quit()
