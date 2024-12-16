extends Label

func _process(delta):
	# Update the label text with the formatted time
	text = "Level Time: " + Global.get_level_time_formatted() + "\nTotal Time: " + Global.get_total_time_formatted()
