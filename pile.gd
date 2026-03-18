extends TextureButton

@export var clean_num: int

var amount_cleaned: int

var collectable_scene = load("res://collectable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	amount_cleaned += 1
	
	if amount_cleaned >= clean_num:
		spawn_collectable()
		
func spawn_collectable() -> void:
	var collectable_instance = collectable_scene.instantiate()
	collectable_instance.position = position + Vector2(100, 100)
	get_parent().add_child(collectable_instance)
