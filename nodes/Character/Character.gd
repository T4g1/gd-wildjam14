extends Node2D
"""
Base class for NPC and Player
"""


export (String) var firstname = "Jonh"


var speech_bubble: SpeechBubble


func _ready():
	speech_bubble = $SpeechBubble
	speech_bubble.set_name(firstname)


func say(text: String):
	speech_bubble.say(text)


func think(text: String):
	speech_bubble.think(text)