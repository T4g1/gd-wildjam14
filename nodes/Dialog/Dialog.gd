extends Node
class_name Dialog
"""
Given some charcters, start dialog based on them
"""


var InkRuntime = load("res://addons/inkgd/runtime.gd")
var Story = load("res://addons/inkgd/runtime/story.gd")
var characters: Array
var story


func start_story(_characters):
	_load_story("res://assets/dialogs/test.json")
	_bind_externals()
	characters = _characters
	continue_story()


func continue_story():
	while story.can_continue:
		var text = story.continue()
		
		var character = get_character()
		var mood = story.variables_state.get("mood")
		if mood == "think":
			character.think(text)
		else:
			character.say(text)
	
		if story.current_choices.size() <= 0:
			yield(character.speech_bubble, "speech_over")
		else:
			character.speech_bubble.disable_close()
	
	if story.current_choices.size() > 0:
		var character = get_character() # Only/Always player?
		character.prompt(story.current_choices)
		character.choice_bubble.connect("choice_done", self, "_choice_done")


func _choice_done(index):
	story.choose_choice_index(index)
	continue_story()


func get_character():
	"""
	Get a character from the protagonists list given
	"""
	var character_name = story.variables_state.get("character_name")
	
	for character in characters:
		if character.firstname == character_name:
			return character
	
	return null


func _load_story(ink_story_path):
	var ink_story = File.new()
	ink_story.open(ink_story_path, File.READ)
	var content = ink_story.get_as_text()
	ink_story.close()
	
	story = Story.new(content)


func _bind_externals():
	pass


func _ready():
    call_deferred("_add_runtime")


func _exit_tree():
    call_deferred("_remove_runtime")


func _add_runtime():
    InkRuntime.init(get_tree().root)


func _remove_runtime():
    InkRuntime.deinit(get_tree().root)