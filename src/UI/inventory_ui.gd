extends CanvasLayer

@onready var grid = $Panel/GridContainer
@onready var sell_button = $SellButton
@onready var money_label = $Money

var slot_scene = preload("res://src/UI/inventory_slot.tscn")

var selected_index = -1

func _ready() -> void:
	visible = false 
	sell_button.disabled = true


func update_display():
	for child in grid.get_children():
		child.queue_free()
		
	var inventory = DataManager.game_data.inventory
	for i in range(inventory.size()):
		var item = inventory[i]
		
		var new_slot = slot_scene.instantiate()
		new_slot.get_node("Label").text = str(item.quantity)
		var slot_texture = load(item.texture_path)
		new_slot.get_node("SlotTexture").texture = slot_texture
		
		new_slot.pressed.connect(_on_slot_selected.bind(i))
		
		grid.add_child(new_slot)
		
		
func toggle():
	visible = !visible
	if visible:
		update_display()


func _on_slot_selected(index: int):
	selected_index = index
	sell_button.disabled = false
	
	
func _on_sell_button_pressed() -> void:
	if selected_index == -1: return
	
	var inventory = DataManager.game_data.inventory
	var item = inventory[selected_index]
	
	
	
func update_money():
	money_label = DataManager.game_data.money
