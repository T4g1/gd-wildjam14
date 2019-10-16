extends Spatial
class_name Character
"""
Base class for NPC and Player
"""

signal choice_done


export (String) var firstname = "Jonh"
export(String, FILE, "*.json") var path_story


var dialog: Dialog
var speech_bubble: SpeechBubble
var choice_bubble: ChoiceBubble


func _ready():
	assert(path_story != "")
	
	dialog = $Dialog
	dialog.load_story(path_story)
	
	speech_bubble = $UI/SpeechBubble
	speech_bubble.set_name(firstname)
	
	choice_bubble = $UI/ChoiceBubble


func _process(_delta):
	Utils.spatial_to_control_position(self, $UI)


func say(text: String):
	speech_bubble.say(text)


func think(text: String):
	speech_bubble.think(text)


func prompt(choices: Array):
	choice_bubble.prompt(choices)


func continue_story():
	$Dialog.continue_story()


func _on_choice_done(index):
	emit_signal("choice_done", index)