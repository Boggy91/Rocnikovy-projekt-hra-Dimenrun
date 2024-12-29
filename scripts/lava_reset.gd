extends StaticBody2D


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	print("YOU DIED")
	SceneManager.switch_scene("res://scenes/GAME/you_died.tscn")
