extends Node

var total_time: float = 0.0
var level_time: float = 0.0
var is_timer_active: bool = false
var point: int = 0
var total_points: int = 0
var difficulty: String = "Normal"  # Default difficulty
var levels = [
	"res://scenes/LEVELS/Level 1.tscn",
	"res://scenes/LEVELS/Level 2.tscn",
	"res://scenes/LEVELS/Level 3.tscn",
	"res://scenes/LEVELS/Level 4.tscn",
	"res://scenes/LEVELS/Level 5.tscn",
	"res://scenes/LEVELS/Level 6.tscn",
	"res://scenes/LEVELS/Level 7.tscn",
	"res://scenes/LEVELS/Level 8.tscn",
]

var current_level_index = 0
var highest_unlocked_level: int = 0  
var best_scores: Array = []
var level_star_ratings: Array = []

func reset_points():
	point = 0

func add_point():
	point += 1

func get_point() -> int:
	return point

func add_to_total_points(points: int) -> void:
	total_points += points

func get_total_points():
	return total_points

func start_level_timer():
	level_time = 0.0
	is_timer_active = true

func stop_level_timer():
	is_timer_active = false

func update_timers(delta: float):
	if is_timer_active:
		level_time += delta
		total_time += delta

func get_total_time_formatted() -> String:
	return format_time(total_time)

func get_level_time() -> float:
	return level_time

func get_level_time_formatted() -> String:
	return format_time(level_time)

func format_time(seconds_input: float) -> String:
	var minutes: int = int(seconds_input / 60)
	var seconds: int = int(seconds_input) % 60
	return "%02d:%02d" % [minutes, seconds]

func get_next_level() -> String:
	if current_level_index + 1 < levels.size():
		current_level_index += 1
		highest_unlocked_level = max(highest_unlocked_level, current_level_index)
		return levels[current_level_index]
	return ""

func is_level_unlocked(level_index: int) -> bool:
	return level_index <= highest_unlocked_level

func set_current_level(level_index: int) -> void:
	if level_index < levels.size():
		current_level_index = level_index
		highest_unlocked_level = max(highest_unlocked_level, current_level_index)

func save_level_score(points: int, time: float, star_count: int):
	var level_index = current_level_index
	add_to_total_points(points)
	if best_scores.size() <= level_index:
		best_scores.resize(level_index + 1)
	var existing_best = best_scores[level_index]
	if existing_best == null or points > existing_best["points"] or (points == existing_best["points"] and time < existing_best["raw_time"]):
		best_scores[level_index] = {
			"level": level_index + 1,
			"points": points,
			"raw_time": time, # Store raw time for comparisons
			"time": format_time(time) # Store formatted time for display
		}
	if level_star_ratings.size() <= level_index:
		level_star_ratings.resize(level_index + 1)
	level_star_ratings[level_index] = star_count

func get_best_score(level_index: int) -> Dictionary:
	if level_index < best_scores.size():
		return best_scores[level_index]
	return {}

func get_scoreboard() -> Array:
	return best_scores

func get_level_star_rating(level_index: int) -> int:
	if level_index < level_star_ratings.size():
		return level_star_ratings[level_index]
	return 0

func reset_game():
	total_time = 0.0
	level_time = 0.0
	is_timer_active = false
	point = 0
	total_points = 0
	current_level_index = 0
	highest_unlocked_level = 0
	best_scores.clear()
	level_star_ratings.clear()
	var save_data = {
		"difficulty": difficulty,
		"total_time": total_time,
		"level_time": level_time,
		"is_timer_active": is_timer_active,
		"point": point,
		"total_points": total_points,
		"current_level_index": current_level_index,
		"highest_unlocked_level": highest_unlocked_level,
		"best_scores": best_scores,
		"level_star_ratings": level_star_ratings
	}
	SaveManager.save_data(save_data)

func save_game():
	var save_data = {
		"difficulty": difficulty,
		"total_time": total_time,
		"level_time": level_time,
		"is_timer_active": is_timer_active,
		"point": point,
		"total_points": total_points,
		"current_level_index": current_level_index,
		"highest_unlocked_level": highest_unlocked_level,
		"best_scores": best_scores,
		"level_star_ratings": level_star_ratings
	}
	SaveManager.save_data(save_data)

func load_game():
	var save_data = SaveManager.load_data()
	if save_data:
		difficulty = save_data.get("difficulty", "Normal")
		total_time = save_data.get("total_time", 0.0)
		level_time = save_data.get("level_time", 0.0)
		is_timer_active = save_data.get("is_timer_active", false)
		point = save_data.get("point", 0)
		total_points = save_data.get("total_points", 0)
		current_level_index = save_data.get("current_level_index", 0)
		highest_unlocked_level = save_data.get("highest_unlocked_level", 0)
		best_scores = save_data.get("best_scores", [])
		level_star_ratings = save_data.get("level_star_ratings", [])

func has_saved_game() -> bool:
	var save_data = SaveManager.load_data()
	return save_data and save_data.has("current_level_index")
