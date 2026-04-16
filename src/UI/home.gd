extends Node

var world_btn_scene = load("res://src/UI/world_button.tscn")
var world_scenes = ["res://src/Worlds/world_1.tscn"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# adds the buttons to navigate to the worlds
	for point in $"World Buttons".get_children():
		var button_inst = world_btn_scene.instantiate()
		button_inst.position = point.position
		button_inst.world_scene = world_scenes[0]
		$"World Buttons".add_child(button_inst)
		
	SignalBus.disable_back_btn.emit()
				
	DataManager.load_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_delete_save_data_pressed() -> void:
	DataManager.delete_save_data()
