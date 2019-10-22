tool
extends "res://nodes/Interactable/Interactable.gd"
class_name Lift
"""
Lift to move the player between floor levels
"""

onready var spawn = $Spawn

var spawn_position


func _ready():
	spawn_position = spawn.global_transform.origin


func _on_use():
	"""
	Teleport target to next lift
	"""
	var lifts = get_tree().get_nodes_in_group("lift")
	var index = lifts.find(self)
	var player = Utils.get_player()
	var target = lifts[(index + 1) % lifts.size()]
	
	player.teleport_to(target.spawn_position)