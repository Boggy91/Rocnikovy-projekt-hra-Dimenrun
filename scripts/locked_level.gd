extends Node

func _on_level_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
