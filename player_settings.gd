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
		
var _keyThrust : InputEventKey
var keyThrust : InputEventKey:
	get: 
		return _keyThrust
	set(val):
		_keyThrust = val
		SaveKey("thrust", val)
		
#var _volume : float
#var volume : float:
	#get: 
		#return _volume
	#set(val):
		#_volume = val
		#SaveVolume(val)
		#
#var _volume : float
#var volume : float:
	#get: 
		#return _volume
	#set(val):
		#_volume = val
		#SaveVolume(val)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var config = ConfigFile.new()
	config.load(config_file_location)
	volume = config.get_value(section, volume_key, 1)
	
	
	#InputMap.action_erase_events("thrust")
	#InputMap.action_erase_events("rRot")
	#InputMap.action_erase_events("lRot")
	#
	#InputMap.action_add_event(actionAssigning, eventKey)
	#thrustValueLabel.text = .as_text()
	#rotateRightValueLabel.text = InputMap.action_get_events("rRot")[0].as_text()
	#rotateLeftValueLabel.text = InputMap.action_get_events("lRot")[0].as_text()

func SaveVolume(volume : float):
	var config = ConfigFile.new()
	config.set_value(section, volume_key, volume)
	config.save(config_file_location)
	
func SaveKey(action : String, mapping : InputEventKey):
	print(type_string(typeof(InputMap.action_get_events("thrust")[0])))
	#config.set_value(section, input_mapping_key+action, mapping.as_text_keycode())
	#config.save(config_file_location)
