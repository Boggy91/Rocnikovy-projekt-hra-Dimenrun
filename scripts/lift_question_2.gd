extends StaticBody2D

const Balloon = preload("res://dialogue/balloon.tscn")

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var lift_question_1: StaticBody2D = $"."
@onready var platform: CollisionShape2D = $Platform
@onready var question: Area2D = $Question
@onready var game_manager: Node = %"game manager"
@onready var block: CollisionShape2D = $Block


func _on_question(body: Node2D) -> void:
	if body.name == "CharacterBody2D": 
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/lift_question_2.dialogue"), "start")
		question.position = Vector2(10000,500000)

func _on_answer_a(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/wrong answer.dialogue"), "start")
		game_manager.decrease_health()
		body.hit(300)

func _on_answer_b(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/wrong answer.dialogue"), "start")
		game_manager.decrease_health()
		body.hit(300)

func _on_answer_c(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		platform.position = Vector2(480,140)
		block.position = Vector2(10000, 10000)
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/correct answer.dialogue"), "start")


func _on_answer_d(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://dialogue/wrong answer.dialogue"), "start")
		game_manager.decrease_health()
		body.hit(300)
