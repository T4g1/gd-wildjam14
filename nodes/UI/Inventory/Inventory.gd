extends Control
class_name Inventory
"""
Handle the player inventory
"""

export (float) var apparition_speed = 1.0
export (float) var hidding_speed = 0.2
export (int) var offset = 25

var displayed_position: Vector2
var hidden_position: Vector2
var hidded = true

onready var background = $MarginContainer/Background


func _ready():
	displayed_position = rect_position
	
	hidden_position = Vector2(0, 0)
	hidden_position.x = offset - background.rect_size.x
	
	rect_position = hidden_position
	hidded = true


func _unhandled_event(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		_on_display()


func _on_hide():
	hidded = true
	$Tween.stop_all()
	$Tween.interpolate_property(self, "rect_position", rect_position, hidden_position, hidding_speed, Tween.TRANS_LINEAR, 0)
	$Tween.start()
	

func _on_display():
	hidded = false
	$Tween.stop_all()
	$Tween.interpolate_property(self, "rect_position", rect_position, displayed_position, apparition_speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()


func _on_input(event):
	if event is InputEventMouseButton and \
		event.button_index == BUTTON_LEFT and \
		event.pressed:
		if hidded:
			_on_display()
		else:
			_on_hide()
