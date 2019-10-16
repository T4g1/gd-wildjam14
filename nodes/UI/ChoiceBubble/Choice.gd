extends Control
class_name Choice
"""
Represent an option in the ChoiceBubble
"""

signal choice_done

var selection_id: int


func init(text: String, _selection_id: int):
	$Label.text = text
	selection_id = _selection_id


func _on_button_down():
	emit_signal("choice_done", selection_id)


func _on_active():
	$Label.set("custom_colors/font_color", Utils.WHITE)


func _on_iddle():
	$Label.set("custom_colors/font_color", Utils.BLACK)