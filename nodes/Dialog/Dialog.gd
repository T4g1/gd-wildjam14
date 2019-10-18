extends Node
class_name Dialog
"""
Given some charcters, start dialog based on them
"""

signal dialog_start
signal dialog_end

var Story = load("res://addons/inkgd/runtime/story.gd")
var story


func _ready():
	var __ = connect("dialog_start", Utils.get_game(), "on_dialog_start")
	__ = connect("dialog_end", Utils.get_game(), "on_dialog_end")


func load_story(ink_story_path):
	var ink_story = File.new()
	ink_story.open(ink_story_path, File.READ)
	var content = ink_story.get_as_text()
	ink_story.close()
	
	story = Story.new(content)


func continue_story():
	emit_signal("dialog_start")
	
	story.variables_state.set("paused", 0)
	
	var player = Utils.get_player()
	var character
	
	while story.can_continue and story.variables_state.get("paused") == 0:
		var text = story.continue()
		character = get_character_from_story()
		
		var zoom_targets = story.get_current_tags()
		if zoom_targets.size() > 0:
			Utils.zoom_on(zoom_targets)
		
		print(text)
		
		var mood = story.variables_state.get("character_mood")
		if mood == "think":
			character.think(text)
		else:
			character.say(text)
	
		if story.current_choices.size() <= 0:
			character.speech_bubble.set_close_action(true)
			yield(character.speech_bubble, "closed")
	
	if story.current_choices.size() > 0:
		character.speech_bubble.set_close_action(false)
		player.prompt(story.current_choices)
		player.choice_bubble.connect("choice_done", self, "_choice_done")
	else:
		emit_signal("dialog_end")


func _choice_done(index):
	yield(get_tree(), "idle_frame")
	story.choose_choice_index(index)
	
	for character in get_tree().get_nodes_in_group("characters"):
		character.speech_bubble.hide()
	
	continue_story()


func get_character_from_story():
	var character_name = story.variables_state.get("character_name")
	return Utils.get_character(character_name)