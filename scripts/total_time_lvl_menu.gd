extends Label

func _process(delta):
	# Update the label text with the formatted time
	text = "Total Time: " + Global.get_total_time_formatted()
