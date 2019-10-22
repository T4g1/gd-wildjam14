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
	story.bind_external_function("has", Utils.get_game().inventory, "has")
	story.bind_external_function("move", self, "move")


func continue_story():
	print("emit_start")
	emit_signal("dialog_start")
	
	story.variables_state.set("paused", 0)
	
	var game = Utils.get_game()
	var player = Utils.get_player()
	var character
	var text_display
	
	while story.can_continue and story.variables_state.get("paused") == 0:
		var text = story.continue()
		
		var zoom_targets = story.get_current_tags()
		if zoom_targets.size() > 0:
			Utils.zoom_on(zoom_targets)
		
		# Game over? (triggers next level)
		if story.variables_state.get("game_is_over") == 1:
			return game.on_next_level()
		
		# Realm change triggered ?
		if story.variables_state.get("trigger_switch_realm") == 1:
			story.variables_state.set("trigger_switch_realm", 0)
			game.current_level.switch_realm()
			yield(game.current_level, "realm_changed")
		
		character = get_character_from_story()
		if character == null:
			# For general text display
			text_display = game.pop_up
			
			if text == "":
				continue
			
			game.display_text(text)
		else:
			# A character is talking
			text_display = character.speech_bubble
			if text == "":
				continue
			
			var mood = story.variables_state.get("character_mood")
			
			if mood == "think":
				character.think(text)
			else:
				character.say(text)
			
		# Check no choice are coming
		if story.current_choices.size() <= 0:
			text_display.set_close_action(true)
			yield(text_display, "closed")
	
	if story.current_choices.size() > 0:
		text_display.set_close_action(false)
		player.prompt(story.current_choices)
		player.choice_bubble.connect("choice_done", self, "_choice_done")
	else:
		print("emit_end")
		emit_signal("dialog_end")


func _choice_done(index):
	yield(get_tree(), "idle_frame")
	story.choose_choice_index(index)
	
	for character in get_tree().get_nodes_in_group("characters"):
		character.speech_bubble.hide()
	
	continue_story()


func move(character_name: String, waypoint_name: String):
	var waypoint = Utils.get_waypoint(waypoint_name)
	var character = Utils.get_character(character_name)
	
	if waypoint == null or character == null:
		return
	
	character.move_to(waypoint.global_transform.origin)


func get_character_from_story():
	var character_name = story.variables_state.get("character_name")
	return Utils.get_character(character_name)