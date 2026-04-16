extends TextureButton

var item_id : String = "0"
var amount: int = 1
var item_icon: Texture2D
var item_texture: String
var item_rarity: String
var item_value: int
var display_name: String
var visual_scale: Vector2 = Vector2(0.5, 0.5)

@onready var anim_sprite = $AnimatedSprite2D

var _template: InventoryItem = null

func _ready() -> void:
	if _template:
		_apply_template(_template)
		
	print("Collectable spawned: ID=", item_id, " at ", global_position)
	self.modulate = Color.WHITE 
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	
	if item_texture and not item_icon:
		item_icon = load(item_texture)
	
	if item_icon:
		self.texture_normal = item_icon
	
	# Set a consistent base scale for the clickable area (64x64 in world)
	visual_scale = Vector2(0.5, 0.5)
	
	if anim_sprite and (not anim_sprite.sprite_frames or anim_sprite.sprite_frames.get_animation_names().size() == 0):
		anim_sprite.visible = false
	
	pressed.connect(_on_pressed)
	
	# Spawn animation: Pop up and scale to visual_scale
	self.scale = Vector2.ZERO
	var spawn_tween = create_tween().set_parallel(true)
	spawn_tween.tween_property(self, "scale", visual_scale, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	# Optional: slight random jump
	var target_pos = global_position + Vector2(randf_range(-20, 20), randf_range(-20, 20))
	spawn_tween.tween_property(self, "global_position", target_pos, 0.3)

func _on_pressed():
	# Disable further input to prevent double-clicks
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	print("Collectable clicked: ", item_id)
	
	SignalBus.spawn_floating_text("+1", global_position + Vector2(0, -20), Color.WHITE)
	
	# Collect animation: Shrink and move up
	var collect_tween = create_tween().set_parallel(true)
	collect_tween.tween_property(self, "scale", Vector2.ZERO, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	collect_tween.tween_property(self, "modulate:a", 0.0, 0.3)
	collect_tween.tween_property(self, "global_position:y", global_position.y - 50, 0.3)
	
	# Add to inventory immediately but wait for animation to finish before removing from tree
	add_to_inv()
	collect_tween.chain().tween_callback(queue_free)
	
func init_from_template(template: InventoryItem):
	_template = template
	# Also set immediate properties that don't depend on @onready nodes
	item_id = template.id
	item_rarity = template.rarity
	display_name = template.display_name

func _apply_template(template: InventoryItem):
	item_icon = template.icon
	self.texture_normal = item_icon
	
	if anim_sprite:
		if template.sprite_frames:
			anim_sprite.sprite_frames = template.sprite_frames
			anim_sprite.visible = true
			anim_sprite.play("default")
			
			# If the sprite is small (like 16x16), scale it up to fill the 128x128 button area
			# 16 * 8 = 128. Since button is scaled 0.5, result is 64px in world.
			var frame_tex = anim_sprite.sprite_frames.get_frame_texture("default", 0)
			if frame_tex and frame_tex.get_size().x < 32:
				anim_sprite.scale = Vector2(8, 8)
				anim_sprite.position = Vector2(64, 64) # Center in the 128x128 button
			else:
				anim_sprite.scale = Vector2(1, 1)
				anim_sprite.position = Vector2(0, 0)
		else:
			anim_sprite.visible = false
	
	
func add_to_inv():
	print("Adding to inventory: ID=", item_id, " Amount=", amount)
	var found_item: InventoryItem = null
	
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
		new_item.icon = item_icon
		new_item.display_name = display_name
		if _template:
			new_item.sprite_frames = _template.sprite_frames
		
		DataManager.game_data.inventory.append(new_item)
		
	print("Item added. New inventory size: ", DataManager.game_data.inventory.size())
		
	DataManager.save_game()
