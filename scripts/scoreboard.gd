extends Node

@onready var score_list_container: VBoxContainer = $"ScrollContainer/VBoxContainer"

# Load the custom font resource
const font_file = preload("res://fonts/Audex-Regular.ttf")

func _ready() -> void:
	populate_scores()

func populate_scores() -> void:
	var best_scores = Global.get_scoreboard()

	# Clear existing children
	for child in score_list_container.get_children():
		score_list_container.remove_child(child)
		child.queue_free()

	# Populate the scoreboard with new entries
	for entry in best_scores:
		if entry != null:
			var score_label = Label.new()
			score_label.text = "       Level %d:  Points - %d   Time - %s" % [
				entry["level"], 
				entry["points"], 
				entry["time"]
			]

			# Apply the custom font and size
			if font_file:
				var custom_font := FontFile.new()
				custom_font.font_data = font_file
				score_label.add_theme_font_override("font", custom_font)
				score_label.add_theme_font_size_override("font",30)

			score_list_container.add_child(score_label)

func _on_level_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
