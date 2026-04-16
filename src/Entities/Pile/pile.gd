extends TextureButton

@export var clean_num: int

var amount_cleaned: int

var collectable_scene = load("res://src/Entities/Collectables/collectable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	print("Pile clicked at ", global_position)
	
	# Click feedback: Bounce effect
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(2.6, 2.6), 0.05)
	tween.tween_property(self, "scale", Vector2(2.5, 2.5), 0.1)
	
	amount_cleaned += 1
	
	if amount_cleaned == clean_num:
		spawn_collectable()
		
func spawn_collectable() -> void:
	var rarity_gen = randi_range(0, 100)
	var rarity = get_collectable_rarity(rarity_gen)
	
	var pool = DataManager.item_pools.get(rarity, [])
	
	var collectable_instance = collectable_scene.instantiate()
	collectable_instance.global_position = global_position + Vector2(50, 50)
	collectable_instance.amount = 1
	
	if pool.size() > 0:
		# Pick a random item from the rarity pool
		var item_template = pool[randi() % pool.size()]
		collectable_instance.init_from_template(item_template)
	else:
		# Fallback if pool is empty (keep current placeholder behavior)
		collectable_instance.item_rarity = rarity
		collectable_instance.item_id = "legacy_" + rarity
		collectable_instance.display_name = rarity.capitalize() + " Placeholder"
		if rarity == "common": collectable_instance.item_texture = "res://Assets/common.png"
		elif rarity == "uncommon": collectable_instance.item_texture = "res://Assets/uncommon.png"
		elif rarity == "rare": collectable_instance.item_texture = "res://Assets/rare.png"
		elif rarity == "epic": collectable_instance.item_texture = "res://Assets/epic.png"
		elif rarity == "legendary": collectable_instance.item_texture = "res://Assets/legendary.png"
	
	get_parent().add_child(collectable_instance)
	collectable_instance.move_to_front()
	print("Spawned collectable: ", collectable_instance.item_id, " (", rarity, ") at ", collectable_instance.global_position)
	self.disabled = true

func get_collectable_rarity(rarity_chance):
	if rarity_chance <= 50: return "common"
	elif rarity_chance > 50 and rarity_chance <= 75: return "uncommon"
	elif rarity_chance > 75 and rarity_chance <= 90: return "rare"
	elif rarity_chance > 90 and rarity_chance <= 96: return "epic"
	elif rarity_chance > 96 and rarity_chance <= 100: return "legendary"


func set_item_attributes(id: String, texture: String, rarity: String, value: int, instance):
	instance.item_id = id
	instance.item_texture = texture
