extends "res://nodes/Item/Item.gd"


onready var audio = $TakeSound


func _on_take():
	audio.play()
	print("cling")
	return true