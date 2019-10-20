extends "res://nodes/UI/ContextMenu/ContextMenu.gd"
"""
Special animation for context menu in inventory
"""


func show():
	$Tween.interpolate_property(self, "rect_scale", Vector2(0.0, 0.0), Vector2(full_size, full_size), animation_speed, Tween.TRANS_LINEAR, 0)
	$Tween.start()
	
	visible = true