extends TextureButton

@export var clean_num: int

var amount_cleaned: int

var collectable_scene = load("res://src/Entities/Collectables/collectable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	amount_cleaned += 1
	
	if amount_cleaned == clean_num:
		spawn_collectable()
		
func spawn_collectable() -> void:
	var collectable_instance = collectable_scene.instantiate()
	collectable_instance.position = position + Vector2(100, 100)
	# Add randomness to this and somehow make the texutre more unique to each item
	var rarity_gen = randi_range(0, 100)
	collectable_instance.amount = 1
	collectable_instance.item_rarity = get_collectable_rarity(rarity_gen)
	var temp_rarity = collectable_instance.item_rarity
	if temp_rarity == "common":
		collectable_instance.item_texture = "res://Assets/common.png"
		collectable_instance.item_id = "1"
	elif temp_rarity == "uncommon":
		collectable_instance.item_texture = "res://Assets/uncommon.png"
		collectable_instance.item_id = "2"
	elif temp_rarity == "rare":
		collectable_instance.item_texture = "res://Assets/rare.png"
		collectable_instance.item_id = "3"
	elif temp_rarity == "epic":
		collectable_instance.item_texture = "res://Assets/epic.png"
		collectable_instance.item_id = "4"
	elif temp_rarity == "legendary":
		collectable_instance.item_texture = "res://Assets/legendary.png"
		collectable_instance.item_id = "5"		
	get_parent().add_child(collectable_instance)
	
	
func get_collectable_rarity(id):
	if id <= 50: return "common"
	elif id > 50 and id <= 75: return "uncommon"
	elif id > 75 and id <= 90: return "rare"
	elif id > 90 and id <= 96: return "epic"
	elif id > 96 and id <= 100: return "legendary"


func set_item_attributes(id: String, texture: String, rarity: String, value: int, instance):
	instance.item_id = id
	instance.item_texture = texture
