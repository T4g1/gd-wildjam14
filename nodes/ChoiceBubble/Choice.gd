extends Control
class_name Choice
"""
Represent an option in the ChoiceBubble
"""

signal choice_done

var selection_id: int


func init(text: String, _selection_id: int):
	$Choice.text = text
	selection_id = _selection_id


func _on_button_down():
	emit_signal("choice_done", selection_id)