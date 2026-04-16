extends Camera2D

var is_dragging = false
@onready var can_move = true

@onready var inventory_ui = get_node("InventoryUI")

func _ready() -> void:
	SignalBus.disable_back_btn.connect(_on_disable_back_btn)
	SignalBus.disable_back_btn.connect(_disable_movement)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && can_move:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed
			
	if event is InputEventMouseMotion and is_dragging:
		position -= event.relative * zoom


func _on_inventory_button_pressed() -> void:
	if inventory_ui:
		inventory_ui.toggle()


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/UI/home.tscn")
	

func disable_back_button():
	$BackButton.visible = false
	
	
func _on_disable_back_btn():
	disable_back_button()
	

func _disable_movement():
	can_move = false
