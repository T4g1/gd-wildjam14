extends Control
class_name InventoryItem
"""
Object storing an Item and that can be displayed in the Inventory
"""

onready var sprite = $Container/Sprite

var stored_item = null


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
	return item