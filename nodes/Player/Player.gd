extends "res://nodes/Character/Character.gd"
class_name Player


var in_dialog = false

func _input(event):
	if in_dialog:
		return
	
	# TODO: Talk to other should be handled by click
	if event.is_action_pressed("ui_cancel"):
		Utils.get_character("Moriarty's Shadow").continue_story()