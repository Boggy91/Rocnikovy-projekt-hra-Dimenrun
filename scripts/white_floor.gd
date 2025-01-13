extends StaticBody2D

@onready var point: Area2D = $Point
@onready var floor: CollisionShape2D = $CollisionShape2D
@onready var white_box: Sprite2D = $Sprite2D



func _on_point_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		floor.position = Vector2(10000,10000)
		white_box.position = Vector2(10000,10000)
