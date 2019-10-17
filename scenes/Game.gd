extends Spatial
class_name Game
"""
Handle the game flow: load levels and shit
"""


# warning-ignore:unused_class_variable
var user_has_control = true


func on_dialog_start():
	print("starting dialog")
	Utils.get_player().in_dialog = true
	
	user_has_control = false


func on_dialog_end():
	print("ending dialog")
	Utils.get_player().in_dialog = false
	
	user_has_control = true


func perform_action(node, action: String):
	"""
	Dispatch action given the node the action is performed on and the action performed
	"""
	if node is Item:
		if action == "Take":
			take(node)
	elif node is Character:
		if action == "Talk":
			talk(node)
	else:
		print("Unknown node ", node, " received for action ", action)
		assert(false)


func take(item: Item):
	"""
	Called when the player wants to take an item
	"""
	var __ = Utils.get_inventory().put_item_in(item)
	item._on_take()


func talk(character: Character):
	"""
	Starts a dialog with the given character
	"""
	if Utils.get_player().in_dialog:
		return
		
	character.continue_story()