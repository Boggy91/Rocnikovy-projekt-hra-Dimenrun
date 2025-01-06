extends Node

@onready var drop_down_menu: OptionButton = $Resolution/OptionButton
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_items()

func add_items():
	drop_down_menu.add_item("1280 x 720")
	drop_down_menu.add_item("1280 x 800")
	drop_down_menu.add_item("1920 x 1080")
	drop_down_menu.add_item("1920 x 1200")
	drop_down_menu.add_item("2880 x 1800")
	drop_down_menu.select(2)


#Resolution Settings
func _on_option_button_item_selected(index):
	var current_selected = index
	
	if current_selected == 0:
		DisplayServer.window_set_size(Vector2(1280,720))
	if current_selected == 1:
		DisplayServer.window_set_size(Vector2(1280,800))
	if current_selected == 2:
		DisplayServer.window_set_size(Vector2(1920,1080))
	if current_selected == 3:
		DisplayServer.window_set_size(Vector2(1920,1200))
	if current_selected == 4:
		DisplayServer.window_set_size(Vector2(2880,1800))

#Fullscreen settings
func _on_full_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Music settings
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/Main_menu.tscn")
