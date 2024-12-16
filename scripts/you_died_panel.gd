extends Panel



	
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main_menu.tscn")


func _on_restart_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lvl_menu.tscn")
