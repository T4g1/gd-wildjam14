extends Control
class_name Choice
"""
Represent an option in the ChoiceBubble
"""

const WHITE = Color(1, 1, 1, 1)
const BLACK = Color(0, 0, 0, 1)

signal choice_done

var selection_id: int


func init(text: String, _selection_id: int):
	$Label.text = text
	selection_id = _selection_id


func _on_button_down():
	emit_signal("choice_done", selection_id)


func _on_active():
	$Label.set("custom_colors/font_color", WHITE)


func _on_iddle():
	$Label.set("custom_colors/font_color", BLACK)