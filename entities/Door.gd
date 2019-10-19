extends "res://nodes/Interactable/Interactable.gd"
class_name Door
"""
Simple door requiring key or not to be opened
"""

export (String) var required_item = "Key"
export (bool) var is_open = false
export (bool) var locked = false

var inventory

func _ready():
	inventory = Utils.get_game().inventory
	
	if is_open:
		open()
	else:
		close()


func open():
	rotation.y = deg2rad(120.0)
	is_open = true


func close():
	rotation.y = 0
	is_open = false


func _on_use():
	if inventory.has(required_item):
		locked = false
	
	if locked:
		Utils.get_game().display_text("A key is required...")
	else:
		toggle()

func toggle():
	if is_open:
		close()
	else:
		open()