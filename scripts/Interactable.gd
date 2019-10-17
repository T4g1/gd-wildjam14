extends CollisionObject
class_name Interactable
"""
Handle something that possess a context menu and connect its various actions
"""

# Node to be outlined
export (NodePath) var sprite_path
export (Texture) var texture
export (ShaderMaterial) var outline_material
export (NodePath) var context_menu_path

var sprite: MeshInstance
var context_menu: ContextMenu
var normal_material: SpatialMaterial


func _ready():
	sprite = get_node(sprite_path)
	context_menu = get_node(context_menu_path)
	
	outline_material = outline_material.duplicate()
	outline_material.set_shader_param("texturemap", texture)
	
	normal_material = sprite.mesh.material
	normal_material.albedo_texture = texture


func _process(_delta):
	Utils.spatial_to_control_position(self, context_menu)


func _on_mouse_hover():
	sprite.material_override = outline_material


func _on_mouse_exit():
	sprite.material_override = normal_material


func _on_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if not Utils.get_game().user_has_control:
		return
	
	if event.is_action_released("ui_context"):
		if not context_menu.visible:
			context_menu.show()


func _on_context_action(action):
	Utils.get_game().perform_action(self, action)