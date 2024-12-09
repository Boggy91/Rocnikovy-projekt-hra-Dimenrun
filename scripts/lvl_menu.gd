extends Node

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main_menu.tscn")


func _on_lvl_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level 1.tscn")


func _on_lvl_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level 2.tscn")


func _on_lvl_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level 6.tscn")


func _on_lvl_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level 4.tscn")
