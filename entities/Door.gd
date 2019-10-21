tool
extends "res://nodes/Interactable/Interactable.gd"
class_name Door
"""
Simple door requiring key or not to be opened
"""

export (String) var required_item = "Key"
export (bool) var is_open = false
export (bool) var locked = false
export (float) var closed_angle = 0.0
export (float) var open_angle = 120.0
export (float) var move_speed = 0.5

onready var door_sound = $DoorSound
onready var door_movement = $Tween

var inventory

func _ready():
	inventory = Utils.get_game().inventory
	
	if is_open:
		open()
	else:
		close()


func open():
	door_movement.interpolate_property(self, "rotation", rotation, Vector3(0, deg2rad(open_angle), 0), move_speed, Tween.TRANS_LINEAR, 0)
	door_movement.start()
	
	yield(door_movement, "tween_all_completed")
	
	is_open = true


func close():
	door_movement.interpolate_property(self, "rotation", rotation, Vector3(0, deg2rad(closed_angle), 0), move_speed, Tween.TRANS_LINEAR, 0)
	door_movement.start()
	
	yield(door_movement, "tween_all_completed")
	
	is_open = false


func _on_use():
	dialog.continue_story()
	
	if inventory.has(required_item):
		locked = false
	
	if not locked:
		toggle()


func _on_combination(item: Item):
	if required_item == item.item_name:
		if locked:
			locked = false
			Utils.get_game().display_text("You unlocked that door with \"" + required_item + "\"")
		else:
			Utils.get_game().display_text("Taht door is already unlocked...")
	else:
		Utils.get_game().display_text("This do not seems to be the right place to use that...")
	return false


func toggle():
	door_sound.play()
	
	if is_open:
		close()
	else:
		open()