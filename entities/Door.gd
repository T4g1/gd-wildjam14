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
	print(open_angle)
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


func toggle():
	door_sound.play()
	
	if is_open:
		close()
	else:
		open()