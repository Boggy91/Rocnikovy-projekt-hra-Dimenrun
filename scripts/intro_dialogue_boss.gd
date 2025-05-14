extends StaticBody2D

const Balloon = preload("res://dialogue/balloon.tscn")


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(load("res://dialogue/level_boss_intro.dialogue"), "start")
