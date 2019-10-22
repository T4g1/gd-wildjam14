extends "res://nodes/Character/Character.gd"
class_name Richard


func _on_combination(item):
	if item.item_name == "Chocolate" and dialog.is_story_set("like") and dialog.is_story_set("dislike"):
		dialog.story_set("has_chocolate")
		dialog.continue_story()
		return true
	else:
		Utils.get_game().display_text("This does nothing")
	
	return false