extends "res://nodes/Character/Character.gd"
class_name Player

var in_dialog = false


func _input(event):
	#FIXME: Those are arbitrary test action, for various dialog setup, #TODO #REMOVEME
	if event.is_action_pressed("ui_accept") and not in_dialog:
		Utils.get_character("Moriarty's Shadow").continue_story()
		in_dialog = true
	
	if event.is_action_pressed("ui_left") and not in_dialog:
		Utils.get_character("Jonh").continue_story()
		in_dialog = true