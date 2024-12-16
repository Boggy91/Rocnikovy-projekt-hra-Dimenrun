extends Node

var scene_history: Array = []  # Stack to store paths of visited scenes

# Change to a new scene and add the current scene to the history
func change_scene(new_scene_path: String):
	# Check if the current scene exists and add it to the history stack
	var current_scene = get_tree().current_scene
	if current_scene and current_scene.filename != "":
		var current_scene_path = current_scene.filename
		scene_history.append(current_scene_path)
		print("Added to history: ", current_scene_path)

	# Load the new scene
	var error = get_tree().change_scene(new_scene_path)
	if error != OK:
		print("Error changing to scene: ", new_scene_path)

# Go back to the last scene in history
func go_back():
	if scene_history.size() > 0:
		var previous_scene_path = scene_history.pop_back()
		print("Going back to: ", previous_scene_path)
		var error = get_tree().change_scene(previous_scene_path)
		if error != OK:
			print("Error going back to scene: ", previous_scene_path)
	else:
		print("No previous scene to go back to.")
