extends "res://nodes/Item/Item.gd"
"""
Shadow machine used/created by Erwin
"""


func _on_use():
	dialog.continue_story()


func _on_take():
	Utils.get_game().display_text("Do you really think that a machine of this size will fit inside of your pocket?")
	return false