extends Node

const WHITE = Color(1, 1, 1, 1)
const BLACK = Color(0, 0, 0, 1)


func get_player() -> Player:
	return get_tree().get_nodes_in_group("player").front()


func get_camera() -> Camera2D:
	return get_tree().get_nodes_in_group("camera").front()


func get_game():
	return get_tree().get_root().get_node("main/Game")


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


func spatial_to_control_position(node: Spatial, control: Control):
	"""
	Move a control node to be on top of a given Spatial node
	"""
	var position = node.get_global_transform().origin
	var camera = Utils.get_camera()
	
	var screen_position = camera.unproject_position(position)
	control.rect_position = screen_position