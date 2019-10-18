extends "res://scripts/Interactable.gd"
class_name Character
"""
Base class for NPC and Player
"""

signal choice_done


export (String) var firstname = "Jonh"

onready var speech_bubble = $UI/SpeechBubble
onready var choice_bubble = $UI/ChoiceBubble


func _ready():
	assert(path_story != "")
	
	speech_bubble.set_name(firstname)


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