extends Label

func _process(delta):
	text = "  Your Time: " + Global.get_level_time_formatted()
