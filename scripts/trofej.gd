extends StaticBody2D

const Balloon = preload("res://dialogue/balloon.tscn")

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D": 
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/koniec.dialogue"), "start")
		timer.wait_time = 4.5
		timer.start()

func _on_timer_timeout() -> void:
		timer.stop()
		get_tree().change_scene_to_file("res://scenes/Main_menu.tscn")
		
