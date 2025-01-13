extends Node

func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")


func _on_yes_pressed() -> void:
	Global.reset_game()
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
