extends Label

func _process(delta):
	# Update the label text with the formatted time
	text = "Level Time: " + Global.get_level_time_formatted() 
