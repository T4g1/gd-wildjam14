extends Node


func get_player() -> Player:
	return get_tree().get_nodes_in_group("player").front()


func get_camera() -> Camera2D:
	return get_tree().get_nodes_in_group("camera").front()


func get_character(character_name: String):
	"""
	Get a character from the protagonists list given
	"""
	print("===", character_name, "===")
	for character in get_tree().get_nodes_in_group("characters"):
		if character.firstname == character_name:
			return character
	
	return null


func zoom_on(targets):
	"""
	Retrieve the camera and zoom on the character whose names are in the given list
	"""
	
	# Get all targeted character
	var characters = []
	for character_name in targets:
		var character = get_character(character_name)
		if character != null:
			characters.append(character)
		
	get_camera().zoom_on(characters)