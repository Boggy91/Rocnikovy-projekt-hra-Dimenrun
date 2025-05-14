extends StaticBody2D

const Balloon = preload("res://dialogue/balloon.tscn")


func _on_start_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D": 
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/level_6_intro.dialogue"), "start")
