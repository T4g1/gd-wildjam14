extends Spatial
class_name Title
"""
Title screen
"""

signal play

onready var ui = $UI


func _on_play():
	emit_signal("play")


func _on_quit():
	get_tree().quit()


func hide():
	ui.hide()
	visible = false


func show():
	ui.show()
	visible = true