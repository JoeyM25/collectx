extends TextureButton

@export var world_scene: String

var world_img = load("res://Assets/icon.svg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture_normal = world_img


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().change_scene_to_file(world_scene)
