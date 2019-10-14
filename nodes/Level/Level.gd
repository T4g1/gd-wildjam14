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
	if event.is_action_pressed("ui_select") and can_change_realm():
		var realm = Realms.REAL
		if current_realm == Realms.REAL:
			realm = Realms.SHADOW
		
		change_realm(realm)
	

func can_change_realm():
	"""
	Returns wether or not condition to change realm are fulfilled
	"""
	# TODO: Implement me
	return true


func change_realm(realm):
	var current_realm_node = realm_nodes[current_realm]
	var realm_node = realm_nodes[realm]
	
	#TODO: Transition
	current_realm_node.visible = false
	realm_node.visible = true
	
	current_realm = realm