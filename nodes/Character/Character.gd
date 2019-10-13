extends Node2D
"""
Base class for NPC and Player
"""

signal choice_done


export (String) var firstname = "Jonh"


var speech_bubble: SpeechBubble
var choice_bubble: ChoiceBubble


func _ready():
	speech_bubble = $SpeechBubble
	speech_bubble.set_name(firstname)
	
	choice_bubble = $ChoiceBubble


func say(text: String):
	speech_bubble.say(text)


func think(text: String):
	speech_bubble.think(text)


func prompt(choices: Array):
	choice_bubble.prompt(choices)


func _on_choice_done(index):
	emit_signal("choice_done", index)