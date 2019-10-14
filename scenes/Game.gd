extends Spatial
class_name Game
"""
Handle the game flow: load levels and shit
"""


func on_dialog_start():
	print("starting dialog")
	Utils.get_player().in_dialog = true
	Utils.get_camera().user_controlled = false


func on_dialog_end():
	print("ending dialog")
	Utils.get_player().in_dialog = false
	Utils.get_camera().user_controlled = true