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
	var found = false
	
	for item in DataManager.game_data["inventory"]:
		if item["id"] == item_id:
			item["quantity"] += amount
			found = true
			break
	if not found:
		DataManager.game_data["inventory"].append({"id": item_id, "quantity": amount, "texture": item_texture, "rarity": item_rarity})
		
	print("added to inventory")
		
	DataManager.save_game()
