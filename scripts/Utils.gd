extends Node


func get_player():
	return get_tree().get_nodes_in_group("player").front()


func get_character(character_name: String):
	"""
	Get a character from the protagonists list given
	"""
	print("===", character_name, "===")
	for character in get_tree().get_nodes_in_group("characters"):
		if character.firstname == character_name:
			return character
	
	return null