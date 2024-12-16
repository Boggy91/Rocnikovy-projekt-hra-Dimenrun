extends Node

var scene_stack = []  # Stack to track scene history

func change_scene(new_scene_path: String):
	# Save the current scene before switching
	if get_tree().current_scene:
		scene_stack.append(get_tree().current_scene)
		get_tree().current_scene.free()
	# Load the new scene
	var new_scene = load(new_scene_path).instance()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

func go_back():
	# Check if there are previous scenes in the stack
	if scene_stack.size() > 0:
		var previous_scene = scene_stack.pop_back()
		get_tree().current_scene.free()
		get_tree().root.add_child(previous_scene)
		get_tree().current_scene = previous_scene
	else:
		print("No previous scene to go back to!")
