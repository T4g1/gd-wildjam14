extends Node
class_name Dialog
"""
Given some charcters, start dialog based on them
"""


static func start_dialog(characters: Array):
	# TODO: This is just placeholder for concept test
	var dialogs = [
		"Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world! Get lost looser, i'm off to shadow world!",
		"Oh nose, I broke everyone's shadow :'("
	]

	for i in range(characters.size()):
		var character = characters[i]
		
		character.say(dialogs[i % dialogs.size()])
		yield(character.speech_bubble, "speech_over")