extends "res://nodes/Character/Character.gd"
class_name Player


var in_dialog = false


func _ready():
	interaction_disabled = true


func _input(event):
	if in_dialog:
		return