extends Label

func _process(delta):
	match Global.difficulty:
		"Easy":
			text = "EASY"
		"Normal":
			text = "NORMAL"
		"Hard":
			text = "HARD"
