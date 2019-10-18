extends Spatial
class_name Game
"""
Handle the game flow: load levels and shit
"""


# warning-ignore:unused_class_variable
var user_has_control = true

onready var current_level = $Level1
onready var pop_up = $PopUp


func _ready():
	var __ = pop_up.connect("opened", self, "on_dialog_start")
	__ = pop_up.connect("closed", self, "on_dialog_end")


func on_dialog_start():
	"""
	Can be called to disable further player's interactions
	"""
	Utils.get_player().in_dialog = true
	
	user_has_control = false


func on_dialog_end():
	"""
	Can be called to re-enable player's interactions
	"""
	Utils.get_player().in_dialog = false
	
	user_has_control = true


func perform_action(node, action: String):
	"""
	Dispatch action given the node the action is performed on and the action performed
	"""
	if Utils.get_player().in_dialog:
		return
	
	if action == "Examine":
		examine(node)
	elif action == "Use":
		use(node)
	elif node is Item:
		if action == "Take":
			take(node)
	elif node is Character:
		if action == "Talk":
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