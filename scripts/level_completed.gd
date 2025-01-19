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
	var star_count = calculate_star_rating(Global.get_point(), Global.get_level_time())
	display_stars(star_count)

	# Save the current level stats to the scoreboard (including star count)
	save_level_stats(Global.get_point(), Global.get_level_time(), star_count)
	
	# Reset points for the next level
	Global.reset_points()
	Global.save_game()

func calculate_star_rating(points: int, time: float) -> int:
	if points > 30 and time < 60:
		return 3  # 3 stars
	elif points > 15 and time < 90:
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
	var star_count = calculate_star_rating(Global.get_point(), Global.get_level_time())
	if star_count == 2:
		var next_level_path = Global.get_next_level()
		if next_level_path != "":
			SceneManager.switch_scene(next_level_path)
		else:
			print("No more levels available!")
	else:
		var next_level_path = Global.get_next_level()
		get_tree().change_scene_to_file("res://scenes/GAME/locket_level_stars.tscn")

func _on_menu_pressed() -> void:
	# Go back to the level menu
	var next_level_path = Global.get_next_level()
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
