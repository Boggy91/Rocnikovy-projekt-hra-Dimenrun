extends Node2D

@export var force = -600
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		animated_sprite_2d.animation = "fire" 
		body.velocity.y = force
		timer.wait_time = 0.5
		timer.start()


func _on_timer_timeout() -> void:
	animated_sprite_2d.animation = "default"
