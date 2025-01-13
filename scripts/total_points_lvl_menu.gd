extends Label

func _process(delta):
	# Update the label text with the formatted time
	text = str(Global.get_total_points())
