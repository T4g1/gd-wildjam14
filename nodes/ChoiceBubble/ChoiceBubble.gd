extends Control
class_name ChoiceBubble
"""
Present choice to the player
"""

signal choice_done

var Choice = preload("res://nodes/ChoiceBubble/Choice.tscn")
var choices_container	# Node with all choice children
var choices_labels = [] # Current choice possible
var selected_choice = 0 # Currently selected option


func _ready():
	hide()
	
	choices_container = $NinePatchRect/VBoxContainer


func prompt(choices_ink: Array):
	"""
	Given an array of string, present choices
	"""
	assert(choices_ink.size() > 0)
	
	clear()
	
	for choice in choices_ink:
		var label = Choice.instance()
		label.set_text(choice.text)
		choices_container.add_child(label)
		choices_labels.append(label)
	
	selected_choice = 0
	choices_labels[0].select()
	
	show()


func _input(event):
	if choices_labels.size() <= 0 or not visible:
		return
	
	if event.is_action_pressed("ui_down"):
		change_selection(1)
	if event.is_action_pressed("ui_up"):
		change_selection(-1)
	if Input.is_action_just_pressed("ui_accept"):
		print("accept")
		hide()
		emit_signal("choice_done", selected_choice)


func change_selection(offset):
	choices_labels[selected_choice].deselect()
	
	selected_choice += offset
	if selected_choice < 0:
		selected_choice = choices_labels.size() + selected_choice
	else:
		selected_choice = selected_choice % choices_labels.size()
	
	choices_labels[selected_choice].select()


func clear():
	choices_labels = []
	
	for child in choices_container.get_children():
		child.free()


func hide():
	visible = false


func show():
	visible = true