extends Node

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

func _ready() -> void:
	SettingsManager.load_settings()
	apply_settings()
	Global.load_game()

	# If a saved game exists, keep the old difficulty
	if Global.current_level_index > 0:
		print("Loaded previous game, keeping existing difficulty:", Global.difficulty)
	else:
		# Reset difficulty for new game selection
		Global.difficulty = ""

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

func _on_play_pressed():
	if Global.current_level_index == 0:
		# New game, choose difficulty
		get_tree().change_scene_to_file("res://scenes/GAME/difficulty_menu.tscn")
	else:
		# Continue previous game
		print("Loading saved game...")
		get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/settings.tscn")

func _on_tutorial_pressed() -> void:
	SceneManager.switch_scene("res://scenes/GAME/tutorial.tscn")
