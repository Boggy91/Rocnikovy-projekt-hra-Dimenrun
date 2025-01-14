extends StaticBody2D

@onready var red_floor: StaticBody2D = $"."
@onready var point: Area2D = $Point



func _on_point_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		point.position = Vector2(10000,10000)
		red_floor.position = Vector2(10000,10000)
