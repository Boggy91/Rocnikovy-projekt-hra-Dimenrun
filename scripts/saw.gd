extends RigidBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		print("YOU DIED")
		SceneManager.switch_scene("res://scenes/GAME/you_died.tscn")
		queue_free()
