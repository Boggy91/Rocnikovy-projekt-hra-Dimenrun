extends Area2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


func _on_body_entered(body: Node2D) -> void:
	sprite_2d.animation = "Finished"
	$Timer.start()
	


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/level_completed.tscn")
