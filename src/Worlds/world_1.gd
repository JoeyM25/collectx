extends Node

var pile_scene = load("res://src/Entities/Pile/pile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var world1_seed = "SEED"
	
	World_Functions.generate_world_piles(world1_seed, $"W1 Piles", pile_scene)
	
	DataManager.save_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
