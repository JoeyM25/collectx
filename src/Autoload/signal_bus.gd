extends Node

signal disable_back_btn

func spawn_floating_text(text: String, pos: Vector2, color: Color = Color.WHITE, parent: Node = null):
	var label = Label.new()
	label.text = text
	label.global_position = pos
	label.z_index = 100
	label.add_theme_color_override("font_color", color)
	label.add_theme_constant_override("outline_size", 4)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	
	if parent == null:
		# Fallback to current scene if no parent provided
		Engine.get_main_loop().current_scene.add_child(label)
	else:
		parent.add_child(label)
		
	var tween = label.create_tween().set_parallel(true)
	tween.tween_property(label, "global_position:y", label.global_position.y - 100, 1.0)
	tween.tween_property(label, "modulate:a", 0.0, 1.0)
	tween.chain().tween_callback(label.queue_free)
