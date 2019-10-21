extends "res://nodes/Item/Item.gd"
"""
Family picture for the level one
"""


func _on_take():
	dialog.continue_story()
	return false
