extends StaticBody2D

@onready var game_manager: Node = %"game manager"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_kill: AudioStreamPlayer = $SFX_kill
@onready var sfx_hit: AudioStreamPlayer = $SFX_hit

var killed= false

func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Decrease player health")
		sfx_hit.play()
		game_manager.decrease_health()
		animated_sprite_2d.animation="explode"
		$killed_timer.start()

func _on_killed_timer_timeout() -> void:
	queue_free()
