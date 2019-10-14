extends Spatial
class_name Level
"""
Base for every level
"""

# On which plan the level starts
enum Realms {REAL, SHADOW}
export (Realms) var start_realm

var node_realms: Dictionary
var current_realm: Node


func _ready():
	node_realms = {
		Realms.REAL: $RealWorld,
		Realms.SHADOW: $ShadowRealm
	}
	
	for realm in node_realms.values():
		realm.visible = false
	
	change_plan(node_realms[start_realm])


func change_plan(realm: Node):
	print(realm)
	if current_realm:
		current_realm.visible = false
	
	current_realm = realm
	
	current_realm.visible = true