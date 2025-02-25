extends Node

@onready var points_label: Label = %"Points Label"
@export var hearts : Array [Node]
@onready var points_level: Label = %"points level"

var points = 0
var lives  # We will set this dynamically

func set_difficulty():
	match Global.difficulty:
		"Easy":
			lives = 4  
		"Normal":
			lives = 3  
		"Hard":
			lives = 1  

	update_hearts_display()

func decrease_health():
	lives -= 1
	print("Lives left: ", lives)
	
	update_hearts_display()

	if lives <= 0:
		print("YOU DIED")
		Global.reset_points()
		SceneManager.switch_scene("res://scenes/GAME/you_died.tscn")

func update_hearts_display():
	for h in range(hearts.size()):  # Use `hearts.size()` to support different difficulty levels
		if h < lives:
			hearts[h].show()
		else:
			hearts[h].hide()

func add_point():
	points += 1
	print("Points: ", points)
	points_label.text = "    " + str(points)
	Global.add_point()

func get_point():
	print("Total Points: ", points)
	points_level.text = "    " + str(points)

func _ready():
	set_difficulty()  # Apply the selected difficulty when the game starts
	Global.start_level_timer()

func _process(delta):
	Global.update_timers(delta)

func _on_level_complete():
	Global.stop_level_timer()

	# Print the times for debugging
	print("Level Time: ", Global.get_level_time_formatted())
	print("Total Time: ", Global.get_total_time_formatted())
