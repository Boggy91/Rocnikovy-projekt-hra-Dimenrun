extends Label

func _ready():
	# Get the current points from the Global singleton and set the text
	text = "Points: %d" % Global.write_point()
