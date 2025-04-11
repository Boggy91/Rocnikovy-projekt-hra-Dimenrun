extends Area2D

@onready var game_manager: Node = %"game manager"
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


func _on_body_entered(body):
	if body.is_in_group("player"):
		if body is CharacterBody2D:
			animated_sprite_2d.animation="collected"
			$collected.start()
			game_manager.add_point()
			audio_player.play()


func _on_collected_timeout() -> void:
	queue_free()
