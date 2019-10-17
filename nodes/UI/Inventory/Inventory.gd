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
var preview_position: Vector2
var hidded = true

onready var background = $Background
onready var action_arrow = $ActionArrow
onready var action_tween = $ActionArrow/Tween
onready var container = $Background/Container
onready var movement_tween = $MovementTween
onready var take_item_tween = $TakeItemTween


func _ready():
	displayed_position = rect_position
	
	hidden_position = Vector2(0, 0)
	hidden_position.x = offset - background.rect_size.x
	
	preview_position = hidden_position
	preview_position.x += 10
	
	# Hide by default
	rect_position = hidden_position
	hidded = true


func _unhandled_event(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		_on_display()


func _on_item_in(_item: InventoryItem):
	"""
	Called when an item is inserted in the inventory
	"""
	var growth = 0.05
	var grow_scale = Vector2(1 + growth, 1 + growth)
	movement_tween.interpolate_property(self, "rect_scale", 
		Vector2(1, 1), 
		grow_scale, 
		0.1, Tween.TRANS_LINEAR, 0
	)
	movement_tween.start()
	
	yield(movement_tween, "tween_all_completed")
	
	movement_tween.interpolate_property(self, "rect_scale", 
		grow_scale, 
		Vector2(1, 1), 
		0.1, Tween.TRANS_LINEAR, 0
	)
	movement_tween.start()


func _on_hide():
	hidded = true
	
	action_arrow.rect_rotation = 0
	
	movement_tween.stop_all()
	movement_tween.interpolate_property(self, "rect_position", rect_position, hidden_position, hidding_speed, Tween.TRANS_LINEAR, 0)
	movement_tween.start()
	

func _on_display():
	hidded = false
	
	action_arrow.rect_rotation = 180
	
	movement_tween.stop_all()
	movement_tween.interpolate_property(self, "rect_position", rect_position, displayed_position, apparition_speed, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	movement_tween.start()


func _on_hover():
	if hidded:
		action_tween.interpolate_property(self, "rect_position", hidden_position, preview_position, 0.2, Tween.TRANS_LINEAR, 0)
	
	action_tween.interpolate_property(action_arrow, "rect_scale", Vector2(0.2, 0.2), Vector2(1.2, 1.2), 0.5, Tween.TRANS_LINEAR, 0)
	action_tween.start()


func _on_exit():
	if hidded:
		rect_position = hidden_position
	
	action_arrow.rect_scale = Vector2(1, 1)
	action_tween.stop_all()


func _on_input(event):
	if event is InputEventMouseButton and \
		event.button_index == BUTTON_LEFT and \
		event.pressed:
		if hidded:
			_on_display()
		else:
			_on_hide()


func get_empty_slot():
	"""
	Give one of the empty slots or null if none are free
	"""
	for slot in container.get_children():
		if slot.is_free():
			return slot
	
	return null
