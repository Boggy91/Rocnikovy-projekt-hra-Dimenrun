extends Node

@onready var time_level_completed: Label = %"Time level completed"
@onready var points_level: Label = %"points level"
@export var STARS: Array[Node]  # An array of the 3 star nodes

func _ready() -> void:
	# Display the points and time
	points_level.text = "Points: %d" % Global.get_point()
	time_level_completed.text = "Your Time: " + Global.get_level_time_formatted()

	# Calculate and display the star rating
	var star_count = calculate_star_rating(Global.get_point(), Global.get_level_time())
	display_stars(star_count)

	# Save the current level stats to the scoreboard
	save_level_stats(Global.get_point(), Global.get_level_time())
	
	# Reset points for the next level
	Global.reset_points()

func calculate_star_rating(points: int, time: float) -> int:
	if points > 30 and time < 60:
		return 3  # 3 stars
	elif points > 15 and time < 90:
		return 2  # 2 stars
	else:
		return 1  # 1 star

func display_stars(star_count: int) -> void:
	for i in range(STARS.size()):
		STARS[i].visible = i < star_count

func save_level_stats(points: int, time: float) -> void:
	# Add points and time to the scoreboard in Global or save it to a file
	var stats = {"points": points, "time": time}
	Global.save_level_score(points, time)

func _on_next_level_pressed() -> void:
	var next_level_path = Global.get_next_level()
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("No more levels available!")


func _on_menu_pressed() -> void:
	var next_level_path = Global.get_next_level()
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
