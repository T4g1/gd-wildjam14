extends "res://nodes/Interactable/Interactable.gd"
class_name Character
"""
Base class for NPC and Player
"""

const NEXT_PATH_THRESHOLD = 1.0

signal choice_done


export (String) var firstname = "Jonh"
export (float) var speed = 5.0

onready var speech_bubble = $UI/SpeechBubble
onready var choice_bubble = $UI/ChoiceBubble

var path = []
var path_index = 0
var in_dialog = false


func _ready():
	assert(path_story != "")
	
	speech_bubble.set_name(firstname)


func _physics_process(_delta):
	if in_dialog:
		return
	
	if path_index < path.size():
		var move_vector = path[path_index] - global_transform.origin
		if move_vector.length() <= NEXT_PATH_THRESHOLD:
			path_index += 1
		else:
			var __ = move_and_slide(move_vector.normalized() * speed, Vector3(0, 1, 0))


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