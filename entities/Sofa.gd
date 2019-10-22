tool
extends "res://nodes/Interactable/Interactable.gd"


func _on_examine():
	dialog.continue_story()
	return false