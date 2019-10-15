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
	print(outline_material)
	outline_material = load("res://shader/outline_shadermaterial.tres")
	outline_material = outline_material.duplicate()
	outline_material.set_shader_param("texturemap", texture)
	
	normal_material = sprite.mesh.material
	normal_material.albedo_texture = texture


func _on_mouse_hover():
	sprite.material_override = outline_material


func _on_mouse_exit():
	sprite.material_override = normal_material
