extends StaticBody2D

@onready var white_floor: StaticBody2D = $"."
@onready var point: Area2D = $Point




func _on_point_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		white_floor.position = Vector2(10000,10000)
		point.position = Vector2(10000,10000)
