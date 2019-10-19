extends "res://nodes/Item/Item.gd"

onready var take_sound = $TakeSound


func _on_take():
	take_sound.play()
	
	return true