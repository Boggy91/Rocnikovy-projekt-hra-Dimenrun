extends Node

var total_time: float = 0.0  # Total time spent across all levels
var level_time: float = 0.0  # Time spent in the current level
var is_timer_active: bool = false  # Controls whether the timer is running
var point: int = 0
var levels = [
	"res://scenes/LEVELS/Level 1.tscn",
	 "res://scenes/LEVELS/Level 2.tscn", 
	"res://scenes/LEVELS/Level 3.tscn", 
	"res://scenes/LEVELS/Level 4.tscn", 
	"res://scenes/LEVELS/Level 5.tscn", 
	"res://scenes/LEVELS/Level 6.tscn", 
	"res://scenes/LEVELS/Level 7.tscn"]
	
	
var current_level_index = 0
var scoreboard: Array = []  # Stores the scores and times for each level

# Reset the points for the current level
func reset_points():
	point = 0

# Add a point for the current level
func add_point():
	point += 1

# Get the current points
func get_point() -> int:
	return point

# Start the timer for the level
func start_level_timer():
	level_time = 0.0  # Reset level time
	is_timer_active = true  # Start the timer

# Stop the timer for the level
func stop_level_timer():
	is_timer_active = false  # Stop the timer

# Update timers (called in _process(delta) from a scene or manager)
func update_timers(delta: float):
	if is_timer_active:
		level_time += delta
		total_time += delta

# Get total time formatted as mm:ss
func get_total_time_formatted() -> String:
	return format_time(total_time)

# Get the current level time as a float
func get_level_time() -> float:
	return level_time

# Get the current level time formatted as mm:ss
func get_level_time_formatted() -> String:
	return format_time(level_time)

# Format time in seconds to mm:ss
func format_time(seconds_input: float) -> String:
	var minutes: int = int(seconds_input / 60)
	var seconds: int = int(seconds_input) % 60
	return "%02d:%02d" % [minutes, seconds]

# Get the next level's path
func get_next_level() -> String:
	print("Current level index before increment:", current_level_index)
	if current_level_index + 1 < levels.size():
		current_level_index += 1
		print("Next level index:", current_level_index)
		return levels[current_level_index]
	print("No more levels available!")
	return ""

func is_level_unlocked(level_index: int) -> bool:
	return level_index <= current_level_index

func set_current_level(level_index: int) -> void:
	if level_index < levels.size() and is_level_unlocked(level_index):
		current_level_index = level_index


# Save the score and time for the current level
func save_level_score(points: int, time: float):
	var level_data = {
		"level": current_level_index + 1,
		"points": points,
		"time": format_time(time)
	}
	scoreboard.append(level_data)

# Get the scoreboard data
func get_scoreboard() -> Array:
	return scoreboard

# Reset game progress (for restarting or starting fresh)
func reset_game():
	total_time = 0.0
	level_time = 0.0
	is_timer_active = false
	point = 0
	current_level_index = 0
	scoreboard.clear()
