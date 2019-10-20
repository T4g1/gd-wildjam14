tool
extends Control
class_name ActionButton
"""
Action button that can be used for contextual actions
"""

signal pressed

export (ShaderMaterial) var hover_material
export (Texture) var logo
export (String) var action

onready var sprite = $Button/MarginContainer/VBoxContainer/Sprite
onready var label = $Button/MarginContainer/VBoxContainer/Label
onready var button = $Button


func _ready():
	sprite.material = null
	sprite.texture = logo
	
	label.text = action
	
	button.hint_tooltip = action


func _process(_delta):
	# Update the preview in the editor
	if not Engine.editor_hint:
		return
	
	sprite = $Button/MarginContainer/VBoxContainer/Sprite
	label = $Button/MarginContainer/VBoxContainer/Label
	
	sprite.texture = logo
	label.text = action


func _on_hover():
	sprite.material = hover_material
	label.set("custom_colors/font_color", Utils.BLACK)


func _on_iddle():
	sprite.material = null
	label.set("custom_colors/font_color", Utils.WHITE)


func _on_button_down():
	emit_signal("pressed", action)


func disable():
	visible = false


func enable():
	visible = true
