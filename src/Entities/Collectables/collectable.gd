extends TextureButton

var item_id : String
var amount: int
var item_texture: String
var item_rarity: String
var item_value: int

func _ready() -> void:
	# item_id = "1" # Randomize later to decide rarity of item
	# amount = 1 # Maybe randomize later
	add_to_inv()
	
	
func add_to_inv():
	var found_item: InventoryItem = null
	# var found = false
	
	for item in DataManager.game_data.inventory:
		if item.id == item_id:
			found_item = item
			break
	if found_item:
		found_item.quantity += amount
	else:
		var new_item = InventoryItem.new()
		new_item.id = item_id
		new_item.quantity = amount
		new_item.rarity = item_rarity
		new_item.texture_path = item_texture
		DataManager.game_data.inventory.append(new_item)
		
	print("added to inventory")
		
	DataManager.save_game()
