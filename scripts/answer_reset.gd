extends StaticBody2D

@onready var character_body_2d: CharacterBody2D = $"../../CharacterBody2D"


func _on_area_2d_body_entered(body: Node2D) -> void:
	character_body_2d.position = Vector2(683, 552)


func _on_area_reset_entered(body: Node2D) -> void:
	character_body_2d.position = Vector2(683, 552)
