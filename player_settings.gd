extends Node

const config_file_location = "user://settings.cfg"
const section = "main"
const volume_key = "volumeKey"

var _volume : float
var volume : float:
	get: 
		return _volume
	set(val):
		_volume = val
		SaveVolume(val)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var config = ConfigFile.new()
	config.load(config_file_location)
	volume = config.get_value(section, volume_key, 1)

func SaveVolume(volume : float):
	var config = ConfigFile.new()
	config.set_value(section, volume_key, volume)
	config.save(config_file_location)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
