extends Control
class_name ContextMenu
"""
Contextual menu that appears sometimes with a list of possible actions
"""

export (float) var animation_speed = 0.1


func _input(event):
	if event.is_action_pressed("ui_accept"):
		show()
	if event.is_action_pressed("ui_cancel"):
		hide()


func _ready():
	hide()


func show():
	$Tween.interpolate_property(self, "rect_scale", Vector2(0.0, 0.0), Vector2(1.0, 1.0), animation_speed, Tween.TRANS_LINEAR, 0)
	$Tween.interpolate_property(self, "rect_rotation", 270, 0, animation_speed, Tween.TRANS_LINEAR, 0)
	$Tween.start()
	
	visible = true


func hide():
	visible = false