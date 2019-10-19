extends "res://nodes/Interactable/Interactable.gd"
class_name Door
"""
Simple door requiring key or not to be opened
"""

export (String) var required_item = "Key"
export (bool) var is_open = false
export (bool) var locked = false

onready var door_sound = $DoorSound

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
		dialog.continue_story()
	else:
		toggle()

func toggle():
	door_sound.play()
	
	if is_open:
		close()
	else:
		open()