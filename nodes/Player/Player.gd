extends "res://nodes/Character/Character.gd"
class_name Player

const NEXT_PATH_THRESHOLD = 1.0

onready var interaction_area = $InteractionArea

var speed = 4.0
var path = []
var path_index = 0


# warning-ignore:unused_class_variable
var in_dialog = false


func is_in_range(node: Interactable):
	"""
	Check if the given interactable is in the range of the player
	true if it is
	"""
	return interaction_area.overlaps_body(node)


func _ready():
	interaction_disabled = true


func _physics_process(_delta):
	if in_dialog:
		return
	
	if path_index < path.size():
		var move_vector = path[path_index] - global_transform.origin
		if move_vector.length() <= NEXT_PATH_THRESHOLD:
			path_index += 1
		else:
			var __ = move_and_slide(move_vector.normalized() * speed, Vector3(0, 1, 0))


func move_to(target: Vector3):
	var navigation = Utils.get_navigation()
	if navigation == null:
		return
	
	path = navigation.get_simple_path(global_transform.origin, target)
	path_index = 0