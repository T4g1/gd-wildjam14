extends Node2D
"""
Base class for NPC and Player
"""


var speech_bubble: SpeechBubble


func _ready():
	speech_bubble = $SpeechBubble


func say(text: String):
	speech_bubble.say(text)


func think(text: String):
	speech_bubble.say(text)