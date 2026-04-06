extends Node

func generate_world_piles(seed_str: String, marker_container: Node, pile_scene):
	var rng = RandomNumberGenerator.new()
	rng.seed = seed_str.hash()
	
	var markers = marker_container.get_children()
	
	for marker in markers:
		if rng.randf() < 0.5:
			var pile = pile_scene.instantiate()
			pile.global_position = marker.global_position
			pile.clean_num = randi_range(3, 10)
			marker.get_parent().add_child(pile)
