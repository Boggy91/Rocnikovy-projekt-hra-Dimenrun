extends Node


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main_menu.tscn")