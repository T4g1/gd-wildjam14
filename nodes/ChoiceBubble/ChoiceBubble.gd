extends Control
class_name ChoiceBubble
"""
Present choice to the player
"""

signal choice_done

var Choice = preload("res://nodes/ChoiceBubble/Choice.tscn")
onready var choices_container = $NinePatchRect/MarginContainer/VBoxContainer


func _ready():
	hide()


func prompt(choices_ink: Array):
	"""
	Given an array of string, present choices
	"""
	assert(choices_ink.size() > 0)
	
	clear()
	
	for selection_id in range(choices_ink.size()):
		var choice = choices_ink[selection_id]
		var choice_label = Choice.instance()
		choice_label.init(choice.text, selection_id)
		choice_label.connect("choice_done", self, "_on_choice_done")
		choices_container.add_child(choice_label)
	
	show()


func _on_choice_done(selection_id: int):
	"""
	A button has been selected
	"""
	hide()
	emit_signal("choice_done", selection_id)


func clear():
	for child in choices_container.get_children():
		child.free()


func hide():
	visible = false


func show():
	visible = true