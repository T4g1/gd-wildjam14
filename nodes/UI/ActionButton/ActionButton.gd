extends Control
class_name ActionButton
"""
Action button that can be used for contextual actions
"""

export (ShaderMaterial) var hover_material

onready var button = $Button
onready var sprite = $Button/Sprite


func _ready():
	sprite.material = null


func _on_hover():
	sprite.material = hover_material


func _on_iddle():
	sprite.material = null