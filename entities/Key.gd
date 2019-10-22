tool
extends "res://nodes/Item/Item.gd"

onready var take_sound = $TakeSound


func _on_take():
	take_sound.play()
	
	dialog.continue_story()
	
	return true