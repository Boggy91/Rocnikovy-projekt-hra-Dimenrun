extends Node

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/Main_menu.tscn")

func _on_lvl_1_pressed() -> void:
	access_level(0, "res://scenes/LEVELS/Level 1.tscn")

func _on_lvl_2_pressed() -> void:
	access_level(1, "res://scenes/LEVELS/Level 3.tscn")

func _on_lvl_3_pressed() -> void:
	access_level(2, "res://scenes/LEVELS/Level 6.tscn")

func _on_lvl_4_pressed() -> void:
	access_level(3, "res://scenes/LEVELS/Level 4.tscn")

func access_level(level_index: int, level_path: String) -> void:
	if Global.is_level_unlocked(level_index):
		Global.set_current_level(level_index)
		SceneManager.switch_scene(level_path)
	else:
		get_tree().change_scene_to_file("res://scenes/GAME/locked_level.tscn")
