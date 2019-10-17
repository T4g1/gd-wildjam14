extends "res://scripts/Interactable.gd"
class_name Item
"""
Base class for every item that the user can interact with, pick up or so
"""


func _on_take():
	context_menu.disable("Take")