extends Spatial
class_name Level
"""
Base for every level
"""

# On which plan the level starts
enum Realms {REAL, SHADOW}
export (Realms) var start_realm

var realm_nodes: Dictionary
var current_realm = Realms.REAL


func _ready():
	realm_nodes = {
		Realms.REAL: $RealWorld,
		Realms.SHADOW: $ShadowRealm
	}
	
	for realm_node in realm_nodes.values():
		realm_node.visible = false
	
	change_realm(start_realm)


func _input(event):
	if not Utils.get_game().user_has_control:
		return
	
	if event.is_action_pressed("ui_select") and can_change_realm():
		var realm = Realms.REAL
		if current_realm == Realms.REAL:
			realm = Realms.SHADOW
		
		fade_realm(realm)
	

func can_change_realm():
	"""
	Returns wether or not condition to change realm are fulfilled
	"""
	# TODO: Implement me
	return true


func change_realm(realm):
	"""
	Immediate change of realm
	"""
	var current_realm_node = realm_nodes[current_realm]
	var realm_node = realm_nodes[realm]
	current_realm_node.visible = false
	realm_node.visible = true
	
	current_realm = realm


func fade_realm(realm):
	"""
	Fade animation to the new realm
	"""
	Utils.get_game().user_has_control = false
	var camera = Utils.get_camera()
	
	camera.fade_out()
	yield(camera, "shutter_visible")
	
	change_realm(realm)
	
	camera.fade_in()
	yield(camera, "shutter_hidden")
	
	Utils.get_game().user_has_control= true