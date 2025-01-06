extends Node

# Default settings
var resolution: Vector2 = Vector2(1920, 1080)
var fullscreen: bool = false
var music_volume: float = 1.0  # Full volume
var sfx_volume: float = 1.0    # Full volume

# File path for saved settings
const SETTINGS_FILE: String = "user://settings.cfg"

# Save the settings to the file
func save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("display", "resolution", resolution)
	config.set_value("display", "fullscreen", fullscreen)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.save(SETTINGS_FILE)

# Load the settings from the file
func load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE)
	
	if err == OK:
		resolution = config.get_value("display", "resolution", resolution)
		fullscreen = config.get_value("display", "fullscreen", fullscreen)
		music_volume = config.get_value("audio", "music_volume", music_volume)
		sfx_volume = config.get_value("audio", "sfx_volume", sfx_volume)
	else:
		# If the settings file doesn't exist, save default settings
		save_settings()
