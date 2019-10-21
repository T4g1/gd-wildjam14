extends Control
class_name InventoryItem
"""
Object storing an Item and that can be displayed in the Inventory
"""

onready var sprite = $CenterContainer/Button/Sprite
onready var context_menu = $ContextMenu

var stored_item = null


func _ready():
	context_menu.connect("context_action", self, "_on_context_action")


func _on_context_action(action):
	if not is_free():
		var game = Utils.get_game()
		
		if action == "Use":
			game.select(self)
		else:
			game.perform_action(stored_item, action, true)
	
	context_menu.hide()


func is_free():
	return stored_item == null


func store(item: Item):
	"""
	Set the stored item
	"""
	sprite.texture = item.texture
	stored_item = item


func pop():
	"""
	Remove item and returns it
	"""
	var item = stored_item
	stored_item = null
	sprite.texture = ""
	
	return item


func _on_gui_input(event):
	if not event.is_action_pressed("ui_context"):
		return
	
	if is_free():
		return
	
	if not context_menu.visible:
		context_menu.show()
