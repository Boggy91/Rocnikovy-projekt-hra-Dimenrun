extends Node

@onready var time_level_completed: Label = %"Time level completed"
@onready var points_level: Label = %"points level"
@export var STARS: Array[Node]  # An array of the 3 star nodes

func _ready() -> void:
	# Check if points_level is properly initialized
	if points_level:
		points_level.text = "Points: " + str(Global.get_point())  # Use Global to get points
	else:
		print("Error: points_level is not assigned in the scene.")
	
	time_level_completed.text = "Your Time: " + Global.get_level_time_formatted()

	# Calculate and display the star rating
	var star_count = calculate_star_rating(Global.get_point(), Global.get_level_time(), Global.current_level_index)
	display_stars(star_count)

	# Save the current level stats to the scoreboard (including star count)
	save_level_stats(Global.get_point(), Global.get_level_time(), star_count)
	
	# Reset points for the next level
	Global.reset_points()
	Global.save_game()

func calculate_star_rating(points: int, time: float, level_index: int) -> int:
	# Define custom conditions per level
	var star_requirements = {
		0: { "points": 42, "time": 60 },  # Level 1
		1: { "points": 40, "time": 50 },  # Level 2
		2: { "points": 50, "time": 45 },  # Level 3
		3: { "points": 60, "time": 40 },  # Level 4
		4: { "points": 70, "time": 35 },  # Level 5
		5: { "points": 80, "time": 30 },  # Level 6
		6: { "points": 90, "time": 25 },  # Level 7
		7: { "points": 100, "time": 20 }  # Level 8
	}

	var level_criteria = star_requirements.get(level_index, { "points": 30, "time": 60 })  # Default if not found

	if points >= level_criteria["points"] and time <= level_criteria["time"]:
		return 3  # 3 stars
	elif points >= level_criteria["points"] * 0.5 and time <= level_criteria["time"] * 1.5:
		return 2  # 2 stars
	else:
		return 1  # 1 star

func display_stars(star_count: int) -> void:
	# Display the stars based on the calculated star count
	for i in range(STARS.size()):
		STARS[i].visible = i < star_count

func save_level_stats(points: int, time: float, star_count: int) -> void:
	# Save points, time, and star count for the current level
	Global.save_level_score(points, time, star_count)

func _on_next_level_pressed() -> void:
	# Retrieve the star count for the current level
	var current_level_index = Global.current_level_index
	var star_count = Global.get_level_star_rating(current_level_index)
	
	if star_count > 1:  # At least 2 stars required
		var next_level_path = Global.get_next_level()
		if next_level_path != "":
			SceneManager.switch_scene(next_level_path)
		else:
			print("No more levels available!")
	else:
		var next_level_path = Global.get_next_level()
		# Show the locked level message
		get_tree().change_scene_to_file("res://scenes/GAME/locket_level_stars.tscn")

func _on_menu_pressed() -> void:
	# Go back to the level menu
	var next_level_path = Global.get_next_level()
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
