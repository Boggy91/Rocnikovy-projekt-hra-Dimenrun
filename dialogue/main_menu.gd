extends Node

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lvl_menu.tscn")



func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn")


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
