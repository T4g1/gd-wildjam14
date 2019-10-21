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
export (Resource) var test_level
export (int) var start_level

# warning-ignore:unused_class_variable
onready var inventory = $Inventory
onready var pop_up = $PopUp
onready var cursor = $Cursor

var selected_slot


func _ready():
	var __ = pop_up.connect("opened", self, "on_dialog_start")
	__ = pop_up.connect("closed", self, "on_dialog_end")
	
	if Utils.is_debug():
		# Load debug level
		levels = [ test_level ]
		load_level(0)
	else:
		load_level(start_level)


func _process(_delta):
	cursor.rect_position = get_viewport().get_mouse_position()


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


func select(slot: InventoryItem):
	"""
	Called when players want to use something from inventory
	"""
	selected_slot = slot
	cursor.texture = slot.stored_item.texture


func deselect():
	selected_slot = null
	cursor.texture = null


func handle_combination(node: Interactable):
	"""
	Called when an inventory item is used on an interactable
	"""
	if selected_slot == null:
		return
	
	if node._on_combination(selected_slot.stored_item):
		selected_slot.pop()

	deselect()


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