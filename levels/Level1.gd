extends "res://nodes/Level/Level.gd"
"""
First level: Tutorial
"""

export (float) var hidden_key_position = -4.3
export (float) var shown_key_position = -1.7


onready var master_key = $RealWorld/MasterKey


func _on_start():
	dialog.continue_story()


func _process(_delta):
	"""
	Check to merge Richard and his shadow
	"""
	var player = Utils.get_player()
	if player.knows("richard_sofa") and player.knows("shadow_sofa"):
		if not player.knows("Richard_is_complete"):
			merge("Richard", "Richard's Shadow")
	
	if player.knows("master_key_location"):
		master_key.global_transform.origin.z = shown_key_position
	else:
		master_key.global_transform.origin.z = hidden_key_position