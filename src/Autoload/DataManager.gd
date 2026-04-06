extends Node

func _ready() -> void:
	load_game()

var game_data = {
	"world": {
		"seed": "SEED",
		"generated_on": "3/22/2026",
		"money": 0
	},
	"inventory": []
}

const rarity_prices = {
	"common": 10,
	"uncommon": 20,
	"rare": 50,
	"epic": 75,
	"legendary": 200
}

const SAVE_PATH = "user://savegame.json"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(game_data)
	file.store_string(json_string)
	file.close()
	
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found :,(")
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(json_string)
	
	if error == OK:
		game_data = json.data
	else: print("JSON Parse Error: ", json.get_error_message())
	

func delete_save_data():
	if FileAccess.file_exists(SAVE_PATH):
		var error = DirAccess.remove_absolute(SAVE_PATH)
		if error == OK:
			print("Save file successfully deleted.")
		else:
			print("Error deleting save file: ", error)
			
	game_data = {
		"world": {
			"seed": "SEED",
			"generated_on": "3/22/2026"
		},
		"inventory": []
	}
	get_tree().reload_current_scene()
