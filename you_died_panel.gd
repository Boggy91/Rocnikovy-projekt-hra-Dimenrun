extends Panel


func _on_restart_lvl_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main_menu.tscn")
