extends Panel

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
	Global.reset_points()

func _on_restart_level_pressed() -> void:
	SceneManager.go_back()
