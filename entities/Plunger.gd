extends "res://nodes/Item/Item.gd"
"""
Plunger for the level one
"""


func _on_take():
	dialog.continue_story()
	return true
