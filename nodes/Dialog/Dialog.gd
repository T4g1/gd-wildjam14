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
		var tags = story.get_current_tags()
		var character_name = tags[0]
		var character = get_character(character_name)
		
		character.say(text)
		yield(character.speech_bubble, "speech_over")


func get_character(character_name: String):
	"""
	Get a character from the protagonists list given from its name
	"""
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