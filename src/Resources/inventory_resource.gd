extends Resource
class_name InventoryItem

@export var id: String
@export var quantity: int = 1
@export var rarity: String

@export_group("Visuals")
@export var display_name: String
@export var sprite_frames: SpriteFrames
@export var icon: Texture2D
