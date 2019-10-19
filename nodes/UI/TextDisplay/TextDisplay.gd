extends Control
class_name TextDisplay
"""
Handle some lines of text
"""

signal opened
signal last_lines
signal closed

export (NodePath) var action_indicators_path
export (NodePath) var close_sprite_path
export (NodePath) var continue_sprite_path
export (NodePath) var label_path
export (NodePath) var action_tween_path

onready var action_indicators = get_node(action_indicators_path)
onready var close_sprite = get_node(close_sprite_path)
onready var continue_sprite = get_node(continue_sprite_path)
onready var label = get_node(label_path)
onready var action_tween = get_node(action_tween_path)

var can_close = true


func _ready():
	hide()
	
	# This variables helps determining when the speech is over, be sure to set a reasonable value
	assert(label.max_lines_visible > 0)


func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_move"):
		if on_action():
			get_tree().set_input_as_handled()


func set_text(text : String):
	label.lines_skipped = 0
	label.text = text
	yield(get_tree(), "idle_frame")
	
	display()


func display():
	emit_signal("opened")
	close_sprite.visible = is_last_line_shown() and can_close
	continue_sprite.visible = not is_last_line_shown()
	
	visible = true
	
	action_tween.interpolate_property(action_indicators, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_LINEAR, 0)
	action_tween.start()


func hide():
	visible = false


func on_action() -> bool:
	"""
	Player triggers next lines/end
	return true in case the action was taken effectively
	"""
	if not is_shown():
		return false
	
	if not is_last_line_shown():
		label.lines_skipped += label.max_lines_visible
		
		display()
	
		if is_last_line_shown():
			emit_signal("last_lines")
	elif can_close:
		hide()
		emit_signal("closed")
	
	return true


func set_close_action(value):
	can_close = value
	close_sprite.visible = can_close


func is_shown():
	return visible


func is_last_line_shown():
	"""
	Indicate if the last line of the displayed text is currently shown or not
	"""
	return label.get_line_count() - label.lines_skipped - label.max_lines_visible <= 0


func get_displayed_line_count():
	if is_last_line_shown():
		return label.get_line_count() - label.lines_skipped
	else:
		return label.max_lines_visible