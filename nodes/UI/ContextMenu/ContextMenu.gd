extends Control
class_name ContextMenu
"""
Contextual menu that appears sometimes with a list of possible actions
"""

signal context_action

export (float) var animation_speed = 0.1
export (float, 0.1, 1.0) var full_size = 0.9


func _ready():
	hide()


func _unhandled_input(event):
	if not visible:
		return
	
	# Close the context menu if the player does something unrelated
	if event.is_action("ui_accept") or \
		event.is_action("ui_cancel") or \
		event.is_action("ui_move") or \
		event.is_action("ui_context") or \
		event.is_action("ui_left") or \
		event.is_action("ui_right") or \
		event.is_action("ui_down") or \
		event.is_action("ui_up"):
		hide()


func show():
	$Tween.interpolate_property(self, "rect_scale", Vector2(0.0, 0.0), Vector2(full_size, full_size), animation_speed, Tween.TRANS_LINEAR, 0)
	$Tween.interpolate_property(self, "rect_rotation", 270, 0, animation_speed, Tween.TRANS_LINEAR, 0)
	$Tween.start()
	
	visible = true


func hide():
	visible = false


func disable(action: String):
	_set_action_status(action, false)


func enable(action: String):
	_set_action_status(action, true)


func _set_action_status(action: String, active: bool):
	for action_button in $Actions.get_children():
		if action_button.action == action:
			if active:
				action_button.enable()
			else:
				action_button.disable()


func _on_pressed(action):
	emit_signal("context_action", action)
	hide()