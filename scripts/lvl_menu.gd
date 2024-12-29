extends Node

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/Main_menu.tscn")


func _on_lvl_1_pressed() -> void:
	SceneManager.switch_scene("res://scenes/LEVELS/Level 1.tscn")


func _on_lvl_2_pressed() -> void:
	SceneManager.switch_scene("res://scenes/LEVELS/Level 3.tscn")


func _on_lvl_3_pressed() -> void:
	SceneManager.switch_scene("res://scenes/LEVELS/Level 6.tscn")


func _on_lvl_4_pressed() -> void:
	SceneManager.switch_scene("res://scenes/LEVELS/Level 4.tscn")
