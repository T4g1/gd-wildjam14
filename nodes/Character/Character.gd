extends "res://nodes/Interactable/Interactable.gd"
class_name Character
"""
Base class for NPC and Player
"""

const NEXT_PATH_THRESHOLD = 1.0
const BLOCKED_THRESHOLD = 0.8

signal choice_done
signal stopped			# When a character stops moving
signal destination_reached		# When a character arrives where he wanted to go


export (String) var firstname = "Jonh"
export (float) var speed = 5.0

onready var speech_bubble = $UI/SpeechBubble
onready var choice_bubble = $UI/ChoiceBubble

var path = []
var path_index = 0
var in_dialog = false setget set_in_dialog


func set_in_dialog(value):
	"""
	All character stops when they enter a dialog
	"""
	in_dialog = value
	if in_dialog:
		clear_path()


func _ready():
	assert(path_story != "")
	
	speech_bubble.set_name(firstname)


func _physics_process(delta):
	if in_dialog:
		return
	
	if path.size() > 0:
		process_movement(delta)


func process_movement(delta):
	"""
	Try to reach next path position and increment path index
	When path index is over the path size, movement is completed
	"""
	if path_index >= path.size():
		clear_path()
		emit_signal("destination_reached")
		return
	
	var move_vector = path[path_index] - global_transform.origin
	if move_vector.length() <= NEXT_PATH_THRESHOLD:
		path_index += 1
	else:
		var move_order = move_vector.normalized() * delta * speed
		var effective_move = move_and_slide(move_order, Vector3(0, 1, 0))
		if move_order.length() != effective_move.length() and effective_move.length() < BLOCKED_THRESHOLD:
			print(effective_move.length())
			# Character is blocked
			clear_path()


func clear_path():
	path = []
	emit_signal("stopped")


func is_moving():
	"""
	Character is moving or not
	"""
	return path.size() > 0 and path_index < path.size()


func teleport_to(position: Vector3):
	"""
	Teleport player to given coordinates
	"""
	global_transform.origin = position
	path_index = path.size()


func move_to(target: Vector3):
	var navigation = Utils.get_navigation()
	if navigation == null:
		return
	
	path = navigation.get_simple_path(global_transform.origin, target)
	path_index = 0


func _process(_delta):
	Utils.spatial_to_control_position(self, $UI)


func say(text: String):
	speech_bubble.say(text)


func think(text: String):
	speech_bubble.think(text)


func prompt(choices: Array):
	choice_bubble.prompt(choices)


func continue_story():
	dialog.continue_story()


func _on_choice_done(index):
	emit_signal("choice_done", index)