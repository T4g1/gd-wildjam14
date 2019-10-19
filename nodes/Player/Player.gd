extends "res://nodes/Character/Character.gd"
class_name Player

const NEXT_PATH_THRESHOLD = 1.0

var speed = 4.0
var path = []
var path_index = 0


# warning-ignore:unused_class_variable
var in_dialog = false


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