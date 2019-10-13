extends Node2D


func _input(event):
	if event.is_action_pressed("ui_down"):
		$Dialog.start_story([$MoriartysShadow, $Moriarty])