extends Spatial
class_name Game
"""
Handle the game flow: load levels and shit
"""

signal game_over


# warning-ignore:unused_class_variable
var user_has_control = true
var current_level
var level_index

export (Array, Resource) var levels
export (int) var start_level

onready var inventory = $Inventory
onready var pop_up = $PopUp


func _ready():
	var __ = pop_up.connect("opened", self, "on_dialog_start")
	__ = pop_up.connect("closed", self, "on_dialog_end")
	
	load_level(start_level)


func on_next_level():
	"""
	Trigger next level or game over
	"""
	if level_index < levels.size() - 1:
		load_level(level_index + 1)
	else:
		on_game_over()


func load_level(index: int):
	"""
	Given the index of the level to load, remove the actual one and loads it
	"""
	if current_level:
		remove_child(current_level)
	
	level_index = index
	current_level = levels[level_index].instance()
	add_child(current_level)


func on_game_over():
	"""
	Trigger game over and back to title screen
	"""
	emit_signal("game_over")


func on_dialog_start():
	"""
	Can be called to disable further player's interactions
	"""
	Utils.get_player().in_dialog = true
	
	user_has_control = false
	
	get_tree().call_group("context_menu", "hide")


func on_dialog_end():
	"""
	Can be called to re-enable player's interactions
	"""
	Utils.get_player().in_dialog = false
	
	user_has_control = true


func perform_action(node, action: String, in_inventory=false):
	"""
	Dispatch action given the node the action is performed on and the action performed
	"""
	var player = Utils.get_player()
	if player.in_dialog:
		return
	
	if not in_inventory and not player.is_in_range(node):
		pop_up.set_text("You are too far away to do that")
		return
	
	if action == "Examine":
		examine(node)
	elif action == "Use":
		use(node)
	elif action == "Take":
		take(node)
	elif action == "Talk":
		talk(node)
	else:
		print("Unknown node ", node, " received for action ", action)
		assert(false)


func display_text(text: String):
	pop_up.set_text(text)


func examine(node: Interactable):
	"""
	Display description of given Interactable
	"""
	if node._on_examine():
		display_text(node.description)


func take(item: Item):
	"""
	Called when the player wants to take an item
	"""
	if item._on_take():
		var __ = Utils.get_inventory().put_item_in(item)


func talk(character: Character):
	"""
	Starts a dialog with the given character
	"""
	if character._on_talk():
		character.continue_story()


func use(node: Interactable):
	"""
	Starts a dialog with the given character
	"""
	node._on_use()