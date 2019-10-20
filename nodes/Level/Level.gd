extends Spatial
class_name Level
"""
Base for every level
"""

signal realm_changed

# On which plan the level starts
enum Realms {REAL, SHADOW}
export (Realms) var start_realm
export (String, FILE, "*.json") var path_story
export (Resource) var custom_environment

onready var dialog = $Dialog
onready var real_audio = $RealWorld/Audio
onready var shadow_audio = $ShadowRealm/Audio
onready var switch_realm_sound = $SwitchRealmSound

var realm_nodes: Dictionary
var current_realm = Realms.REAL


func _ready():
	assert(path_story != "")
	
	if custom_environment:
		Utils.get_environment().set_environment(custom_environment)
	
	realm_nodes = {
		Realms.REAL: $RealWorld,
		Realms.SHADOW: $ShadowRealm
	}
	
	for realm_node in realm_nodes.values():
		realm_node.visible = false
	
	dialog.load_story(path_story)
	
	set_realm(start_realm)
	
	yield(get_tree(), "idle_frame")
	_on_start()


func _input(event):
	if not Utils.get_game().user_has_control:
		return
	
	if event.is_action_pressed("ui_select"):
		switch_realm()


func _on_start():
	"""
	Overide for custom behavior
	"""
	pass


func switch_realm():
	"""
	Switch between realms
	"""
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


func set_realm(realm):
	"""
	Immediate and unconditionnal change of realm
	"""
	var current_realm_node = realm_nodes[current_realm]
	var realm_node = realm_nodes[realm]
	current_realm_node.visible = false
	realm_node.visible = true
	
	current_realm = realm
	
	set_audio()


func set_audio():
	"""
	Set correct music in background
	"""
	if current_realm == Realms.SHADOW:
		real_audio.stop()
		shadow_audio.play()
	else:
		real_audio.play()
		shadow_audio.stop()


func fade_realm(realm):
	"""
	Fade animation to the new realm if it is possible right now
	"""
	if not can_change_realm():
		return
	
	switch_realm_sound.play()
	
	Utils.get_game().user_has_control = false
	var camera = Utils.get_camera()
	
	camera.show_shutter()
	yield(camera, "shutter_visible")
	
	set_realm(realm)
	
	camera.hide_shutter()
	yield(camera, "shutter_hidden")
	
	Utils.get_game().user_has_control= true
	emit_signal("realm_changed")