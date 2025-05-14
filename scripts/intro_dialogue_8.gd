extends StaticBody2D

const Balloon = preload("res://dialogue/balloon.tscn")

@onready var jetpack_character: CharacterBody2D = $"../Character/JETPACK Character"

func _on_start_body_entered(body: Node2D) -> void:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/level_8_intro.dialogue"), "start")
