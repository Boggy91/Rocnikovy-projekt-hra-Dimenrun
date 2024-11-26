extends StaticBody2D



func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	get_tree().reload_current_scene()
