extends StaticBody2D

@onready var white_hole: StaticBody2D = $"."
@onready var white_box: RigidBody2D = $"../../Boxes/White_box"


func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	if body==white_box:
		white_hole.position = Vector2(1729, 802.3)
	else:
		pass
