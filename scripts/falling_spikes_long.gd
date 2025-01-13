extends Node2D

@export var speed = 220.0
var current_speed = 0.0

func _physics_process(delta):
	position.y += current_speed * delta


func _on_area_2d_body_entered(body: Node):
	if (body.name == "CharacterBody2D"):
		print("YOU DIED")
		Global.reset_points()
		SceneManager.switch_scene("res://scenes/GAME/you_died.tscn")
		queue_free()
		
	else:
		queue_free()


func _on_player_detect_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		fall()


func fall():
	current_speed = speed 
	await get_tree().create_timer(3).timeout
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
