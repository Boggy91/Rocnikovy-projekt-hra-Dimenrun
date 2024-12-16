extends Node

var total_time: float = 0.0  # Total time spent across all levels
var level_time: float = 0.0  # Time spent in the current level
var is_timer_active: bool = false  # Controls whether the timer is running

func start_level_timer():
	level_time = 0.0  # Reset level time
	is_timer_active = true  # Start the timer

func stop_level_timer():
	is_timer_active = false  # Stop the timer

func update_timers(delta: float):
	if is_timer_active:
		level_time += delta
		total_time += delta

func get_total_time_formatted() -> String:
	return format_time(total_time)

func get_level_time_formatted() -> String:
	return format_time(level_time)

func format_time(seconds_input: float) -> String:
	var minutes: int = int(seconds_input / 60)
	var seconds: int = int(seconds_input) % 60
	# Ensure the format is always two digits for both minutes and seconds
	return "%02d:%02d" % [minutes, seconds]
