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
		
	if characters.size() <= 0:
		return
	
	# Compute bounding rect
	var first_character = characters.pop_front()
	var upper_left = first_character.position
	var lower_right = first_character.position
	
	for character in characters:
		var position = character.position
		if position.x < upper_left.x:
			upper_left.x = position.x
		if position.y < upper_left.y:
			upper_left.y = position.y
		
		if position.x + 500 > lower_right.x:
			lower_right.x = position.x + 500
		if position.y > lower_right.y:
			lower_right.y = position.y

	var middle_point = upper_left + (lower_right - upper_left) / 2
	print(middle_point)
	get_camera().position = middle_point