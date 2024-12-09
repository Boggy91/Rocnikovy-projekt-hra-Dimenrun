extends Node
@onready var points_label: Label = %"Points Label"
@export var hearts : Array[Node]

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
