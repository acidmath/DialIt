extends Node

const config_file_location = "user://settings.cfg"
const section = "main"
const volume_key = "volumeKey"
const input_mapping_key = "inputMappingKey"

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
	
	# update volume
	volume = config.get_value(section, volume_key, 1)
	
	# update input mappings
	var customInputActions = ["thrust", "rRot", "lRot"]
	for customInputAction in customInputActions:
		var defaultMapping = InputMap.action_get_events(customInputAction)[0]
		InputMap.action_erase_events(customInputAction)
		var savedMapping = config.get_value(section, input_mapping_key+customInputAction, defaultMapping)
		InputMap.action_add_event(customInputAction, savedMapping)

func SaveVolume(volumeVal : float):
	var config = ConfigFile.new()
	config.set_value(section, volume_key, volumeVal)
	config.save(config_file_location)
	
func SaveKey(action : String):
	var config = ConfigFile.new()
	config.set_value(section, input_mapping_key+action, InputMap.action_get_events(action)[0])
	config.save(config_file_location)
