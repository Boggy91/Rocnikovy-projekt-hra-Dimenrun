extends Node

var save_path: String = "res://savegame.save"

func save_data(data: Dictionary) -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_var(data)
		file.close()
		print("Game saved successfully!")

func load_data() -> Dictionary:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			var data = file.get_var()
			file.close()
			print("Game loaded successfully!")
			return data
		else:
			print("Failed to open save file.")
	else:
		print("Save file not found.")
	return {}
