extends Node

@export var STARSLVL1: Array[Node]
@export var STARSLVL2: Array[Node]
@export var STARSLVL3: Array[Node]
@export var STARSLVL4: Array[Node]
@export var STARSLVL5: Array[Node]
@export var STARSLVL6: Array[Node]
@export var STARSLVL7: Array[Node]
@export var STARSLVL8: Array[Node]
@onready var game_saved_reseted: Label = $"Game Saved_Reseted"

func _ready() -> void:
	Global.save_game()
	# Display the star ratings for each level when the menu is loaded
	display_level_stars(0, STARSLVL1)
	display_level_stars(1, STARSLVL2)
	display_level_stars(2, STARSLVL3)
	display_level_stars(3, STARSLVL4)
	display_level_stars(4, STARSLVL5)
	display_level_stars(5, STARSLVL6)
	display_level_stars(6, STARSLVL7)
	display_level_stars(7, STARSLVL8)

func _on_reset_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/reset_game.tscn")
	

func _on_save_game_pressed() -> void:
	Global.save_game()
	game_saved_reseted.text = "Game Saved"
	$"Game Saved_Reseted/Game Saved Timer".start()
	
func _on_game_saved_timer_timeout() -> void:
	game_saved_reseted.text = " "


func _on_scoreboard_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/scoreboard.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/Main_menu.tscn")

func _on_lvl_1_pressed() -> void:
	access_level(0, "res://scenes/LEVELS/Level 1.tscn")

func _on_lvl_2_pressed() -> void:
	access_level(1, "res://scenes/LEVELS/Level 2.tscn")

func _on_lvl_3_pressed() -> void:
	access_level(2, "res://scenes/LEVELS/Level 3.tscn")

func _on_lvl_4_pressed() -> void:
	access_level(3, "res://scenes/LEVELS/Level 4.tscn")
	
func _on_lvl_5_pressed()-> void:
	access_level(4,"res://scenes/LEVELS/Level 5.tscn" )

func _on_lvl_6_pressed() -> void:
	access_level(5, "res://scenes/LEVELS/Level 6.tscn")
	
func _on_lvl_7_pressed() -> void:
	access_level(6, "res://scenes/LEVELS/Level 7.tscn")
	
func _on_lvl_8_pressed() -> void:
	access_level(7, "res://scenes/LEVELS/Level 8.tscn")

func _on_boss_button_pressed() -> void:
	if Global.get_total_points() > 1000:
		access_level(8, "res://scenes/LEVELS/boss_fight.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/GAME/boss_level_locked.tscn")

	
func access_level(level_index: int, level_path: String) -> void:
	# Check if the level is unlocked and the player can access it
	if Global.is_level_unlocked(level_index):
		if level_index == 0 or Global.get_level_star_rating(level_index - 1) >= 2:
			Global.set_current_level(level_index)
			SceneManager.switch_scene(level_path)
		else:
			get_tree().change_scene_to_file("res://scenes/GAME/locket_level_stars.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/GAME/locked_level.tscn")

# Function to display the correct number of stars for each level
func display_level_stars(level_index: int, star_nodes: Array[Node]) -> void:
	# Get the star rating for this level
	var star_count = Global.get_level_star_rating(level_index)
	# Update the visibility of stars based on the rating
	for i in range(star_nodes.size()):
		star_nodes[i].visible = i < star_count
		


func _on_time_and_points_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GAME/time_score.tscn")
