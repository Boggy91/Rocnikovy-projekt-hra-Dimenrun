extends Area2D

@onready var game_manager: Node = %"game manager"
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		animated_sprite_2d.animation="collected"
		$collected.start()
		game_manager.add_point()


func _on_collected_timeout() -> void:
	queue_free()
