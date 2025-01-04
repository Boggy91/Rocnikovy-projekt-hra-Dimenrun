extends StaticBody2D


# Called when the node enters the scene tree for the first time.
const Balloon = preload("res://dialogue/balloon.tscn")

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var lift_question_1: StaticBody2D = $"."


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D": 
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/lift_question_1.dialogue"), "start")
		timer.wait_time = 0.15
		timer.start()


func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 0)
	lift_question_1.position = Vector2(4500,500)
