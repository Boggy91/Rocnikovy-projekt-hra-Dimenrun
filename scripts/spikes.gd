extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var game_manager: Node = %"game manager"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		print("Decrease player health")
		game_manager.decrease_health()
		body.hit(300)
