extends Control
class_name SpeechBubble
"""
Handle some lines of text
TODO: Think style
"""

signal speech_over

export (Texture) var normal_bubble
export (Texture) var think_bubble

onready var action_indicators = $Background/ActionIndicators
onready var close_square = $Background/ActionIndicators/CloseSquare
onready var continue_arrow = $Background/ActionIndicators/ContinueArrow

var can_close = true
var patch : NinePatchRect
var label : Label


func set_name(text: String):
	$Background/NinePatchRect/Name.text = text


func say(text: String):
	patch.texture = normal_bubble
	patch.region_rect = Rect2(0, 0, 60, 60)
	set_text(text)


func think(text: String):
	patch.texture = think_bubble
	patch.region_rect = Rect2(0, 0, 200, 100)
	set_text(text)


func _ready():
	hide()
	
	patch = $Background
	label = $Background/Text
	
	# This variables helps determining when the speech is over, be sure to set a reasonable value
	assert(label.max_lines_visible > 0)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		on_action()


func set_text(text : String):
	label.lines_skipped = 0
	label.text = text
	yield(get_tree(), "idle_frame")
	
	display()


func display():
	patch.rect_size = Vector2(500, 150)
	
	$Tween.interpolate_property(self, "rect_scale", Vector2(0.0, 0.0), Vector2(1.0, 1.0), 0.1, Tween.TRANS_LINEAR, 0)
	$Tween.start()
	
	close_square.visible = is_last_line_shown() and can_close
	continue_arrow.visible = not is_last_line_shown()
	
	$ActionTween.interpolate_property(action_indicators, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_LINEAR, 0)
	$ActionTween.start()
	
	visible = true


func hide():
	visible = false


func on_action():
	"""
	Player triggers next lines/end
	"""
	if not is_shown():
		return
	
	if not is_last_line_shown():
		label.lines_skipped += label.max_lines_visible
				
		display()
	elif can_close:
		hide()
		emit_signal("speech_over")


func set_close_action(value):
	can_close = value
	close_square.visible = can_close


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