extends Node
@onready var points_label: Label = %"Points Label"
@export var hearts : Array[Node]
@onready var points_level: Label = %"points level"





var points = 0
var lives = 3

func decrease_health():
	lives -= 1
	print(lives)
	for h in 3:
		if (h<lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	if (lives == 0):
		get_tree().change_scene_to_file("res://scenes/you_died.tscn")


func add_point():
	points += 1
	print(points)
	points_label.text = "    "+ str(points)
	Global.add_point()
	
	
	
func get_point():
	print(points)
	points_level.text = "    "+ str(points)
	
	
func _ready():
	# Start the level timer when the level begins
	Global.start_level_timer()

func _process(delta):
	# Update the timers every frame
	Global.update_timers(delta)

func _on_level_complete():
	# Stop the timer when the level is completed
	Global.stop_level_timer()

	# Print the times for debugging
	print("Level Time: ", Global.get_level_time_formatted())
	print("Total Time: ", Global.get_total_time_formatted())

	
