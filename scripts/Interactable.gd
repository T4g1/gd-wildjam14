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
export (NodePath) var dialog_path
# warning-ignore:unused_class_variable
export (String, MULTILINE) var description
export(String, FILE, "*.json") var path_story

onready var sprite = get_node(sprite_path)
onready var context_menu = get_node(context_menu_path)
onready var dialog = get_node(dialog_path)
var normal_material: SpatialMaterial

var interaction_disabled = false


func _ready():
	var __ = context_menu.connect("context_action", self, "_on_context_action")
	
	outline_material = outline_material.duplicate()
	outline_material.set_shader_param("texturemap", texture)
	
	normal_material = sprite.get_surface_material(0)
	normal_material.albedo_texture = texture
	
	if path_story != "":
		dialog.load_story(path_story)


func _process(_delta):
	Utils.spatial_to_control_position(self, context_menu)


func _on_mouse_hover():
	if interaction_disabled:
		return
	
	sprite.material_override = outline_material


func _on_mouse_exit():
	if interaction_disabled:
		return
	
	sprite.material_override = normal_material


func _on_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if interaction_disabled:
		return
	
	if not Utils.get_game().user_has_control:
		return
	
	if event.is_action_released("ui_context"):
		show_context_menu()


func show_context_menu():
	"""
	Displays its context menu
	"""
	if not context_menu.visible:
		context_menu.show()


func _on_context_action(action):
	if interaction_disabled:
		return
	
	Utils.get_game().perform_action(self, action)
