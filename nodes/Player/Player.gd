extends "res://nodes/Character/Character.gd"
class_name Player


# warning-ignore:unused_class_variable
var in_dialog = false


func _ready():
	interaction_disabled = true