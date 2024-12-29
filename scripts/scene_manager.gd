# SceneManager.gd
extends Node

var previous_scene_path: String = ""  # Path of the previous scene
var current_scene_path: String = ""  # Path of the current scene

# Function to switch scenes and track the previous one
func switch_scene(new_scene_path: String):
	if current_scene_path != "":
		previous_scene_path = current_scene_path
	current_scene_path = new_scene_path
	get_tree().change_scene_to_file(new_scene_path)

# Function to go back to the previous scene
func go_back():
	if previous_scene_path != "":
		var temp = current_scene_path
		get_tree().change_scene_to_file(previous_scene_path)
		current_scene_path = previous_scene_path
		previous_scene_path = temp
	else:
		print("No previous scene to go back to!")
