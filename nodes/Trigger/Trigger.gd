extends Area
class_name Trigger
"""
Area triggered on various conditions
"""

signal triggered

export (bool) var oneshot = false

var trigger_count = 0


func _on_body_entered(_body):
	if oneshot and trigger_count > 0:
		return
	
	on_triggered()
	emit_signal("triggered")
	trigger_count += 1


func _on_body_exited(_body):
	pass


func on_triggered():
	"""
	Override for behavior
	"""
	pass