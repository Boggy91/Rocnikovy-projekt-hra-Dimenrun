extends Node


func _on_easy_pressed():
	Global.difficulty = "Easy"
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")

func _on_normal_pressed():
	Global.difficulty = "Normal"
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")

func _on_hard_pressed():
	Global.difficulty = "Hard"
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/Main_menu.tscn")
