extends Node

@onready var drop_down_menu: OptionButton = $Resolution/OptionButton
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var fullscreen_button: CheckButton = $FullScreen # Fullscreen toggle button

func _ready() -> void:
	# Load and apply settings
	SettingsManager.load_settings()
	apply_settings()
	add_items()

	# Set sliders to saved positions
	var music_slider = $Volume/MusicSlider
	var sfx_slider = $Volume/SFXSlider

	if not music_slider:
		print("Error: MusicSlider node not found.")
	else:
		music_slider.value = SettingsManager.music_volume

	if not sfx_slider:
		print("Error: SFXSlider node not found.")
	else:
		sfx_slider.value = SettingsManager.sfx_volume

	# Set fullscreen button state based on saved value
	if fullscreen_button:
		fullscreen_button.pressed
		SettingsManager.fullscreen = true

# Populate the dropdown menu for resolution options
func add_items():
	drop_down_menu.add_item("1280 x 720")
	drop_down_menu.add_item("1280 x 800")
	drop_down_menu.add_item("1920 x 1080")
	drop_down_menu.add_item("1920 x 1200")
	drop_down_menu.add_item("2880 x 1800")

	var resolution_to_index = {
		Vector2(1280, 720): 0,
		Vector2(1280, 800): 1,
		Vector2(1920, 1080): 2,
		Vector2(1920, 1200): 3,
		Vector2(2880, 1800): 4,
	}

	var index = resolution_to_index.get(SettingsManager.resolution, 2)
	drop_down_menu.select(index)

# Update resolution when an option is selected
func _on_option_button_item_selected(index):
	var resolutions = [
		Vector2(1280, 720),
		Vector2(1280, 800),
		Vector2(1920, 1080),
		Vector2(1920, 1200),
		Vector2(2880, 1800),
	]
	var selected_resolution = resolutions[index]
	DisplayServer.window_set_size(selected_resolution)
	SettingsManager.resolution = selected_resolution
	SettingsManager.save_settings()

# Toggle fullscreen mode
func _on_full_screen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	SettingsManager.fullscreen = button_pressed
	SettingsManager.save_settings()

# Adjust music volume
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)
	SettingsManager.music_volume = value
	SettingsManager.save_settings()

# Adjust sound effects volume
func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
	SettingsManager.sfx_volume = value
	SettingsManager.save_settings()

# Navigate back to the main menu
func _on_main_menu_button_pressed() -> void:
	SettingsManager.save_settings()
	get_tree().change_scene_to_file("res://scenes/GAME/Main_menu.tscn")

# Apply saved settings to the game
func apply_settings():
	DisplayServer.window_set_size(SettingsManager.resolution)
	
	if SettingsManager.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(SettingsManager.music_volume))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, SettingsManager.music_volume < 0.05)

	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(SettingsManager.sfx_volume))
	AudioServer.set_bus_mute(SFX_BUS_ID, SettingsManager.sfx_volume < 0.05)
