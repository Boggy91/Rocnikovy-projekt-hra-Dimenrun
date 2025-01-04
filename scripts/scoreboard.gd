extends Node

@onready var score_list_container: VBoxContainer = $"ScrollContainer/VBoxContainer"

func _ready() -> void:
	populate_scores()

func populate_scores() -> void:
	var best_scores = Global.get_scoreboard()

	for child in score_list_container.get_children():
		score_list_container.remove_child(child)
		child.queue_free()

	for entry in best_scores:
		if entry != null:
			var score_label = Label.new()
			score_label.text = "       Level %d:  Points - %d   Time - %s" % [
				entry["level"], 
				entry["points"], 
				entry["time"]
			 ]

			score_list_container.add_child(score_label)



func _on_level_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/lvl_menu.tscn")
