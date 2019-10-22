extends "res://nodes/Level/Level.gd"
"""
First level: Tutorial
"""


onready var master_key = $MasterKey


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
	
	if not master_key.visible and player.knows("master_key_location"):
		master_key.visible = true