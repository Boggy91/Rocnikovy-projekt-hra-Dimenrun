extends Node

@onready var time_level_compleated: Label = %"Time level compleated"
@onready var points_level: Label = %"points level"
@export var STARS: Array[Node]  # An array of the 3 star nodes

func _ready() -> void:
	# Display the points and time
	points_level.text = "Points: %d" % Global.write_point()  # Use Global.get_points() instead of write_point
	time_level_compleated.text = "Your Time: " + Global.get_level_time_formatted()

	# Calculate and display the star rating
	var star_count = calculate_star_rating(Global.write_point(), Global.get_level_time())
	display_stars(star_count)
	
	Global.reset_points()

func calculate_star_rating(points: int, time: float) -> int:
	# Define your criteria for star ratings
	if points > 30 and time < 60:
		return 3  # 3 stars
	elif points > 15 and time < 90:
		return 2  # 2 stars
	else:
		return 1  # 1 star

func display_stars(star_count: int) -> void:
	# Loop through the STARS array and make stars visible based on the count
	for i in range(STARS.size()):
		STARS[i].visible = i < star_count


func _on_next_level_pressed() -> void:
	pass # Replace with function body.


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
