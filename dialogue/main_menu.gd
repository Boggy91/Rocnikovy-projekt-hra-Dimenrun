extends Node

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")



func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/controls.tscn")


func _on_tutorial_pressed() -> void:
	SceneManager.switch_scene("res://scenes/GAME/tutorial.tscn")
