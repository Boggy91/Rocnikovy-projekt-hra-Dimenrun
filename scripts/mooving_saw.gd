extends Path2D


@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer


func _ready() -> void:
	if not loop:
		animation.play("move")
		animation.speed_scale = speed_scale
		set_process(false)

func _process(delta: float) -> void:
	path.progress += speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		print("YOU DIED")
		SceneManager.switch_scene("res://scenes/GAME/you_died.tscn")
		queue_free()
