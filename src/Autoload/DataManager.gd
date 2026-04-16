extends Node

var game_data: GameData = GameData.new()
const SAVE_PATH = "user://savegame.tres"

# Item pools by rarity
var item_pools = {
	"common": [],
	"uncommon": [],
	"rare": [],
	"epic": [],
	"legendary": []
}

func _ready() -> void:
	load_game()
	_initialize_item_pools()

func _initialize_item_pools():
	# Load existing items - in the future, we could scan a directory
	register_item(load("res://src/Resources/common_gem.tres"))
	# Add more items here as they are created

func register_item(item: InventoryItem):
	if item and item.rarity.to_lower() in item_pools:
		item_pools[item.rarity.to_lower()].append(item)
		print("Registered item: ", item.display_name, " (", item.rarity, ")")

const rarity_prices = {
	"common": 10,
	"uncommon": 20,
	"rare": 50,
	"epic": 75,
	"legendary": 200
}

func save_game():
	print("Saving game...")
	var error = ResourceSaver.save(game_data, SAVE_PATH)
	if error != OK:
		print("Error saving game: ", error)
	else:
		print("Game saved successfully.")
	
func load_game():
	if ResourceLoader.exists(SAVE_PATH):
		var loaded_data = ResourceLoader.load(SAVE_PATH)
		if loaded_data is GameData:
			game_data = loaded_data
		else:
			print("Loaded data is not GameData. Creating new one.")
			create_new_save()
	else:
		print("No save file found. Creating new one.")
		create_new_save()

func create_new_save():
	game_data = GameData.new()
	game_data.generated_on = Time.get_datetime_dict_from_system()
	save_game()

func delete_save_data():
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
	create_new_save()
	get_tree().reload_current_scene()
