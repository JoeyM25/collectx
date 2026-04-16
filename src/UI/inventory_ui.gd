extends CanvasLayer

@onready var grid = find_child("GridContainer")
@onready var sell_button = find_child("SellButton")
@onready var money_label = find_child("Money")
@onready var item_name_label = find_child("ItemName")
@onready var item_rarity_label = find_child("ItemRarity")
@onready var item_value_label = find_child("ItemValue")

var slot_scene = preload("res://src/UI/inventory_slot.tscn")

var selected_index = -1

func _ready() -> void:
	visible = false 
	sell_button.disabled = true
	_clear_details()

func _clear_details():
	if item_name_label: item_name_label.text = "Select an item"
	if item_rarity_label: 
		item_rarity_label.text = "---"
		item_rarity_label.add_theme_color_override("font_color", Color.GRAY)
	if item_value_label:
		item_value_label.text = ""

func update_display():
	for child in grid.get_children():
		child.queue_free()
		
	var inventory = DataManager.game_data.inventory
	print("Updating display. Inventory size: ", inventory.size())
	for i in range(inventory.size()):
		var item = inventory[i]
		
		var new_slot = slot_scene.instantiate()
		var label = new_slot.find_child("Label")
		var texture_rect = new_slot.find_child("SlotTexture")
		
		if label: label.text = str(item.quantity)
		if texture_rect: texture_rect.texture = item.icon
		
		new_slot.pressed.connect(_on_slot_selected.bind(i))
		
		grid.add_child(new_slot)
	
	if selected_index >= inventory.size():
		selected_index = -1
		_clear_details()
		sell_button.disabled = true

func toggle():
	visible = !visible
	if visible:
		update_display()
		update_money()


func _on_slot_selected(index: int):
	# Reset previous selection color
	if selected_index != -1 and selected_index < grid.get_child_count():
		grid.get_child(selected_index).self_modulate = Color.WHITE
	
	selected_index = index
	sell_button.disabled = false
	
	# Highlight new selection (light blue)
	if selected_index != -1 and selected_index < grid.get_child_count():
		grid.get_child(selected_index).self_modulate = Color(0.5, 0.8, 1.0, 1.0)
		
		var item = DataManager.game_data.inventory[selected_index]
		item_name_label.text = item.display_name if item.display_name else "Item " + item.id
		item_rarity_label.text = item.rarity.capitalize()
		_set_rarity_color(item.rarity.to_lower())
		
		var price = DataManager.rarity_prices.get(item.rarity.to_lower(), 0)
		item_value_label.text = "Value: " + str(price) + " Gold"

func _set_rarity_color(rarity: String):
	var color = Color.WHITE
	match rarity:
		"common": color = Color.GRAY
		"uncommon": color = Color.GREEN
		"rare": color = Color.DEEP_SKY_BLUE
		"epic": color = Color.PURPLE
		"legendary": color = Color.ORANGE
	item_rarity_label.add_theme_color_override("font_color", color)

func _on_sell_button_pressed() -> void:
	if selected_index == -1: return
	
	var inventory = DataManager.game_data.inventory
	var item = inventory[selected_index]
	
	var price = DataManager.rarity_prices.get(item.rarity.to_lower(), 0)
	DataManager.game_data.money += price
	
	# Floating text juice
	SignalBus.spawn_floating_text("+" + str(price) + " Gold", money_label.global_position, Color.YELLOW, self)
	
	item.quantity -= 1
	if item.quantity <= 0:
		inventory.remove_at(selected_index)
		selected_index = -1
		sell_button.disabled = true
		_clear_details()
	
	DataManager.save_game()
	update_display()
	update_money()
	
func update_money():
	money_label.text = str(DataManager.game_data.money)
