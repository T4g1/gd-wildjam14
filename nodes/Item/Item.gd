tool
extends PhysicsBody
class_name Item
"""
Base class for every item that the user can interact with, pick up or so
"""

export (Texture) var texture
export (ShaderMaterial) var outline_material

onready var sprite = $Sprite

var normal_material: SpatialMaterial


func _ready():
	outline_material.shader.shader_params.texturemap = texture
	
	normal_material = sprite.material
	normal_material.albedo_texture = texture


func _on_mouse_hover():
	print("show outline")
	sprite.material = outline_material


func _on_mouse_exit():
	print("hide outline")
	sprite.material = normal_material
