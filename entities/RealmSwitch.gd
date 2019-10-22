extends "res://nodes/Interactable/Interactable.gd"
class_name RealmSwitch
"""
Allows the player to travel to Shadow Realm and back
"""


func _on_use():
	var game = Utils.get_game()
	if Utils.get_player().can("shadow_switching"):
		game.current_level.switch_realm()
	else:
		game.display_text("You don't know yet how to use that")